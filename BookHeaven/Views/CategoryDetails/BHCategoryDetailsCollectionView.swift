//
//  CategoryDetailsCollectionView.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 19.01.2023.
//

import UIKit

class BHCategoryDetailsCollectionView: UIView {

    let viewModel: BHCategoryDetailsViewModel
    
    let progressView: UIActivityIndicatorView = {
        let pv = UIActivityIndicatorView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.hidesWhenStopped = true
        pv.startAnimating()
        return pv
    }()
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.alpha = 0
        cv.isHidden = true
        
        cv.register(BHBooksCellView.self, forCellWithReuseIdentifier: BHBooksCellView.cellIdentifier)
        
        return cv
    }()
    
    init(frame: CGRect, viewModel: BHCategoryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        addSubViews(collectionView, progressView)
        addConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init coder: is Unsupported")
    }
    
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
    
    

}
