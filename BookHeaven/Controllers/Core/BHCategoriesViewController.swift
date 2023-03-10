//
//  BHCategoriesViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit

class BHCategoriesViewController: UIViewController, BHCategoriesCollectionViewDelegate {

    func onSelectCategory(category: BHCategory) {
        navigationController?.pushViewController(BHCategoryDetailsCollectionViewController(category: category, libraryViewModel: libraryViewModel), animated: true)
    }
    
    let libraryViewModel: BHLibraryViewModel
    
    
    init(libraryViewModel: BHLibraryViewModel) {
        self.libraryViewModel = libraryViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    var bhCategoriesCollectionView = BHCategoriesCollectionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"

        bhCategoriesCollectionView.delegate = self
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
