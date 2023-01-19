//
//  BHLibraryCollectionView.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 19.01.2023.
//

import Foundation
import UIKit


class BHLibraryCollectionView: UIView{
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)

        cv.register(BHBooksCellView.self, forCellWithReuseIdentifier: BHBooksCellView.cellIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
