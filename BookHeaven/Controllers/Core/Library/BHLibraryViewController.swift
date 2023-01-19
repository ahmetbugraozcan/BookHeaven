//
//  BHLibraryViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit
import CoreData

class BHLibraryViewController: UIViewController, BHLibraryViewControllerDelegate {
    func didSelectBook(with book: BHBook) {
        let viewModel = BHBooksDetailViewModel(book)
        navigationController?.pushViewController(BHBookDetailsViewController(viewModel: viewModel), animated: true)
    }
    
    
    var viewModel = BHLibraryViewModel()
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(BHBooksCellView.self, forCellWithReuseIdentifier: BHBooksCellView.cellIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .systemBackground
        //        view.translatesAutoresizingMaskIntoConstraints = false
        viewModel.getBooksFromCoreData()
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        view.addSubview(collectionView)
        addConstraints()
        title = "Library"
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }
    
}

protocol BHLibraryViewControllerDelegate: AnyObject{
    func didSelectBook(with book: BHBook)
}
