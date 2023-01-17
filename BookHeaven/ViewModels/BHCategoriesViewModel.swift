//
//  BHCategoriesViewModel.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//

import Foundation
import UIKit


final class BHCategoriesViewModel: NSObject{
    let categories = BHCategory.categories
}


extension BHCategoriesViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BHCategoriesCellView.cellReuseIdentifier, for: indexPath) as? BHCategoriesCellView else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:100, height: 100)
    }
}
