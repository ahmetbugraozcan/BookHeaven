//
//  s.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 19.01.2023.
//

import Foundation

protocol BHCategoryDetailsCollectionViewControllerDelegate: AnyObject {
    func categoryDidLoadFirstBooks()
    func onSelectBook(book: BHBook)
    func didLoadNextBooks(indexPaths: [IndexPath])
}
