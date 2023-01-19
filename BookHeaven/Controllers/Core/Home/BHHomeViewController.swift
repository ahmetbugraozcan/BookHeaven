//
//  BHHomeViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 7.01.2023.
//

import UIKit
import CoreData

/// View that contains list of Book
final class BHHomeViewController: UIViewController, BHBooksListViewDelegate {
    
    var container: NSPersistentContainer!
    
    init(container: NSPersistentContainer) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    func didSelectBook(book: BHBook) {
        navigationController?.pushViewController(BHBookDetailsViewController(viewModel: BHBooksDetailViewModel(book)), animated: true)
    }
 
    let collectionView = BHBooksListView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Books"
        collectionView.delegate = self
        
        view.addSubViews(collectionView)
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
