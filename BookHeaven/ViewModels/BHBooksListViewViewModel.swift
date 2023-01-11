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
    var books: [Book] = []
    
    weak var delegate: BHBooksListView?
    
    func fetchBooks(){
        BHService.shared.request(request: BHService.getBooksRequest, expected: AllBooksResponse.self) { [weak self] result in
            switch result {
            case .success(let success):
                guard let books = success.results else {
                    return
                }
                
                self?.books = books
                DispatchQueue.main.async {
                    self?.delegate?.didLoadFirstBooks()
                }
            case .failure(let failure):
                print(String(describing: failure))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item seleccted at \(indexPath.row)")
        let selectedBook = books[indexPath.row]
        self.delegate?.didSelectBook(selectedBook)
    }

}



