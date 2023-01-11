//
//  BHHomeViewController+DataSource.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit

extension BHHomeCollectionView{
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Book.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Book.ID>
    
    
    func updateSnapshot(reloading idsThatChanged: [Book.ID] = []){
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(books.map({$0.id}), toSection: 0)
        dataSource.apply(snapshot)
//        snapshot.reloadItems(idsThatChanged)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell,indexPath: IndexPath, itemIdentifier: Book.ID){
        
        var contentConfiguration = cell.defaultContentConfiguration()
        
        let book: Book = book(for: itemIdentifier)
        
        contentConfiguration.text = book.title
        cell.contentConfiguration = contentConfiguration
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .red
        cell.backgroundConfiguration = backgroundConfiguration
        
        
        
    }
    
    func book(for id: Book.ID) -> Book{
        let index = books.indexOfBooks(with: id)
        return books[index]
    }
}
