//
//  BHHomeViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit

class BHHomeCollectionViewController: UIViewController {
    
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        
        view.addSubViews(collectionView)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        addConstraints()
    }

    func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

}
