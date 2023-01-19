//
//  BHCategoryViewModel.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 19.01.2023.
//

import Foundation
import UIKit

class BHCategoryDetailsViewModel:NSObject {
    var paginationLoading: Bool = false
    var category: BHCategory?
    var bookForCategories: [BHBook] = []
    private var nextString: String?
    
    var shouldShowLoadMoreIndicator: Bool{
        return nextString != nil
    }
    
    weak var delegate: BHCategoryDetailsCollectionViewControllerDelegate?
 
    func getFirstBooksForCategories(){
        guard let category = self.category else {
            return
        }

        print(String(describing: BHService.getBookCategoryRequest(with: category)))
        BHService.shared.request(request: BHService.getBookCategoryRequest(with: category), expected: BHAllBooksResponse.self) { result in
            switch result {
            case .success(let success):
                guard let results = success.results else {
                    return
                }
                self.nextString = success.next
                self.bookForCategories.append(contentsOf: results)
                self.delegate?.categoryDidLoadFirstBooks()
                
                
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    func getNextBooksForCategories(){
        if(paginationLoading){
            return
        }
        print("we are at bottom")
        guard nextString != nil, let url = URL(string: nextString!), let request = BHRequest(url: url) else {
            return
        }
        
        paginationLoading = true
        BHService.shared.request(request: request, expected: BHAllBooksResponse.self) { result in
            switch result {
            case .success(let success):
                guard let results = success.results else {
                    self.paginationLoading = false
                    return
                }
                
                self.nextString = success.next
        
                let newCount = results.count
                let total = self.bookForCategories.count + newCount
                let startingIndex = total - newCount
                
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap { value in
                    return IndexPath(row: value, section: 0)
                }
                self.bookForCategories.append(contentsOf: results)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadNextBooks(indexPaths: indexPathsToAdd)
                    self.paginationLoading = false
                    
                }
                
            case .failure(let failure):
                print(String(describing: failure))
                self.paginationLoading = false
            }
        }
        
    }
}

extension BHCategoryDetailsViewModel: UICollectionViewDataSource ,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookForCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BHBooksCellView.cellIdentifier, for: indexPath) as? BHBooksCellView else {
            fatalError("Unknown cell")
        }
        
        cell.configure(with: bookForCategories[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: BHFooterLoadingView.identifier, for: indexPath) as? BHFooterLoadingView else {
            fatalError("Unsupported footer")
        }
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onSelectBook(book: bookForCategories[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 20, height: 150)
    }
    
}

extension BHCategoryDetailsViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !paginationLoading, !bookForCategories.isEmpty, shouldShowLoadMoreIndicator else {
            return
        }
        

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            let contentHeigth = scrollView.contentSize.height
            let contentOffset = scrollView.contentOffset.y
            let scrollViewHeight = scrollView.frame.height
            
            if(contentHeigth <= 150 + contentOffset + scrollViewHeight){
    
                self.getNextBooksForCategories()
            }
            timer.invalidate()
      
        }
 

        
    }
}
