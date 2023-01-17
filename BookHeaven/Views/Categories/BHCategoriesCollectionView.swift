//
//  BHCategoriesCollectionView.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//

import Foundation
import UIKit




final class BHCategoriesCollectionView: UIView {
    
    weak var delegate: BHCategoriesViewController?
    
    var viewModel = BHCategoriesListViewModel()
    
    var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BHCategoriesCellView.self, forCellWithReuseIdentifier: BHCategoriesCellView.cellReuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        viewModel.delegate = self
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        addSubViews(collectionView)
        addConstraints()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
}

extension BHCategoriesCollectionView: BHCategoriesCollectionViewDelegate {
    func onSelectCategory(category: BHCategory) {
        self.delegate?.onSelectCategory(category: category)
    }
    
    
}
