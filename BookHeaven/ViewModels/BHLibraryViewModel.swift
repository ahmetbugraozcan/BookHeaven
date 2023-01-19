//
//  BHLibraryViewModel.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 19.01.2023.
//

import Foundation
import CoreData
import UIKit

class BHLibraryViewModel: NSObject{
    var libraryItems: [BHBook] = []
//    var container: NSPersistentContainer!
//
//    init(container: NSPersistentContainer) {
//        self.container = container
//    }
//
    
    
    func getBooksFromCoreData(){
        let cdManager = BHCoreDataManager()
        let data = cdManager.fetch(BHBookCDModel.self)
        
        libraryItems.append(contentsOf:  data.compactMap { bookCDModel in
            let book = BHBook.convertCoreDataBookToDomainBook(with: bookCDModel)
            return book
        })
 
    }
    
}

extension BHLibraryViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return libraryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BHBooksCellView.cellIdentifier, for: indexPath) as? BHBooksCellView else {
            fatalError("Unsupported cell ")
        }
        
        cell.configure(with: libraryItems[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 150)
    }
}

