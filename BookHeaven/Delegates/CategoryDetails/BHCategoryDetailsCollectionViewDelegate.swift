//
//  s.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 19.01.2023.
//

import Foundation

protocol BHCategoryDetailsCollectionViewDelegate: AnyObject {
    func didSelectBook(with book: BHBook)
}
