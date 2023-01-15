//
//  BHBooksListViewViewModel.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 9.01.2023.
//

import Foundation
import UIKit

/// ViewModel for BooksList on HomeView
final class BHBooksListViewViewModel:NSObject{
    var books: [BHBook] = []
    
    
    private var isNewBooksLoading = false
    private var shouldShowLoadMoreIndicator:Bool {
        return self.nextAPIString != nil
    }
    
    weak var delegate: BHBooksListView?
    
    
    private var nextAPIString: String? = nil
    
    func fetchBooks(){
        BHService.shared.request(request: BHService.getBooksRequest, expected: BHAllBooksResponse.self) { [weak self] result in
            switch result {
            case .success(let success):
                guard let books = success.results else {
                    return
                }
                
                self?.books = books
                self?.nextAPIString = success.next
                DispatchQueue.main.async {
                    self?.delegate?.didLoadFirstBooks()
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    func fetchNewBooks(){
        guard !isNewBooksLoading else {
            return
        }
        print("asdas")
        self.isNewBooksLoading = true
        guard nextAPIString != nil, let request = BHRequest(url: URL(string: nextAPIString!)) else {
            self.isNewBooksLoading = false
            return
        }
        BHService.shared.request(request: request, expected: BHAllBooksResponse.self) {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let success):
                guard let moreResults = success.results else {
                    return
                }
                
                strongSelf.nextAPIString = success.next
                
                
                let newCount = moreResults.count
                let total = strongSelf.books.count + newCount
                let startingIndex = total - newCount
                
                let indexPathsToAdd : [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap ({
                    return IndexPath(row: $0, section: 0)
                })
                
                strongSelf.books.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreBooks(with: indexPathsToAdd)
                    strongSelf.isNewBooksLoading = false
                }
                
            case .failure(let failure):
                print("failutree \(failure)")
                
                DispatchQueue.main.async {
                    self?.isNewBooksLoading = false
                }

            }
        }
        
        
        
    }
    

    
}

extension BHBooksListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BHBooksCellView.cellIdentifier, for: indexPath) as? BHBooksCellView else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: books[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 20, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100 )
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BHFooterLoadingView.identifier, for: indexPath) as? BHFooterLoadingView else {
            fatalError("Unsupported")
        }
        
        footer.startAnimating()
        
        return footer
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        self.delegate?.didSelectBook(selectedBook)
    }
    
    
}

extension BHBooksListViewViewModel:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isNewBooksLoading, !books.isEmpty, shouldShowLoadMoreIndicator else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let size = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height

            
            if offset >= (size - totalScrollViewFixedHeight - 120) {
                
                self?.fetchNewBooks()
            }
            t.invalidate()
        }
  
    }
}



