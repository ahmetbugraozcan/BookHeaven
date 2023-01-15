//
//  RMBookListViewViewModelDelegate.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 9.01.2023.
//

import Foundation


protocol BHBookListViewViewModelDelegate{
    func didLoadFirstBooks()
    func didSelectBook(_ book: BHBook)
    func didLoadMoreBooks(with indexPaths: [IndexPath])
}
