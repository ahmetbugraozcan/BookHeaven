//
//  BHCategoryViewModel.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 19.01.2023.
//

import Foundation
import UIKit

class BHCategoryDetailsViewModel:NSObject {
    var categoriesLoading: Bool = false
    var category: BHCategory?
    var bookForCategories: [BHBook] = []
    
    weak var delegate: BHCategoryDetailsCollectionViewControllerDelegate?
 
    func getFirstBooksForCategories(){
        guard let category = self.category else {
            return
        }
        
        categoriesLoading = true
        print(String(describing: BHService.getBookCategoryRequest(with: category)))
        BHService.shared.request(request: BHService.getBookCategoryRequest(with: category), expected: BHAllBooksResponse.self) { result in
            switch result {
            case .success(let success):
                guard let results = success.results else {
                    return
                }
                
                self.bookForCategories.append(contentsOf: results)
                self.delegate?.categoryDidLoadFirstBooks()
                
                
            case .failure(let failure):
                print(String(describing: failure))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onSelectBook(book: bookForCategories[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 20, height: 150)
    }
    
}
