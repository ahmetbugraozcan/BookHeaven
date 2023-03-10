//
//  BHCategoryViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//

import UIKit


class BHCategoryDetailsCollectionViewController: UIViewController, BHCategoryDetailsCollectionViewControllerDelegate {
    let libraryViewModel: BHLibraryViewModel
    
    var category: BHCategory
    

    init(category: BHCategory, libraryViewModel: BHLibraryViewModel) {
        self.category = category
        self.libraryViewModel = libraryViewModel
        viewModel.category = category
        self.categoriesList = BHCategoryDetailsCollectionView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    func didLoadNextBooks(indexPaths: [IndexPath]) {
        self.categoriesList.collectionView.insertItems(at: indexPaths)
    }
    
    func onSelectBook(book: BHBook) {
        let viewModel = BHBooksDetailViewModel(book)
        navigationController?.pushViewController(BHBookDetailsViewController(viewModel: viewModel, favoritesViewModel: libraryViewModel), animated: true)
    }
    
    func categoryDidLoadFirstBooks() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.categoriesList.collectionView.alpha = 1.0
                self.categoriesList.collectionView.reloadData()
                self.categoriesList.collectionView.isHidden = false
                self.categoriesList.progressView.stopAnimating()
            }
            
        }
    }

    
    
    var viewModel = BHCategoryDetailsViewModel()
    var categoriesList: BHCategoryDetailsCollectionView
    


    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        viewModel.getFirstBooksForCategories()
        self.title = category.displayString
        
        
        view.addSubViews(categoriesList)
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            categoriesList.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesList.rightAnchor.constraint(equalTo: view.rightAnchor),
            categoriesList.topAnchor.constraint(equalTo: view.topAnchor),
            categoriesList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
