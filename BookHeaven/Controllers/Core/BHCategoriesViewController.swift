//
//  BHCategoriesViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit

class BHCategoriesViewController: UIViewController {

    var bhCategoriesCollectionView = BHCategoriesCollectionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(bhCategoriesCollectionView)
        addConstraints()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            bhCategoriesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bhCategoriesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bhCategoriesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            bhCategoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    


}
