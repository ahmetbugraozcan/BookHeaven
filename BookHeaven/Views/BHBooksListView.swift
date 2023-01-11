//
//  BHBooksList.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 9.01.2023.
//

import UIKit
import Kingfisher



class BHBooksListView: UIView {
    
    
    public weak var delegate: BHBooksListViewDelegate?
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        let collectionView: UICollectionView =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(BHBooksCellView.self, forCellWithReuseIdentifier: BHBooksCellView.cellIdentifier)
        
        return collectionView
    }()
    
    let progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(frame: .zero)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.hidesWhenStopped = true
        progressView.startAnimating()
        return progressView
    }()
    
    let viewModel = BHBooksListViewViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubViews(collectionView, progressView)
        addConstraints()
        
        collectionView.dataSource = viewModel
        viewModel.delegate = self
        collectionView.delegate = viewModel
        
        viewModel.fetchBooks()
        
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }

    func addConstraints(){
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

extension BHBooksListView: BHBookListViewViewModelDelegate{
    func didSelectBook(_ book: Book) {
        delegate?.didSelectBook(book: book)
    }
    
    func didLoadFirstBooks() {
        collectionView.reloadData()
        progressView.stopAnimating()
        collectionView.isHidden = false
        
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.collectionView.alpha = 1.0
        }
        
    }
    
   
    
    
}
