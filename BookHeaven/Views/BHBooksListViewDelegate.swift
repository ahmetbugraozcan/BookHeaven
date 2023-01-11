//
//  BHBooksListViewDelegate.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 10.01.2023.
//

import Foundation
protocol BHBooksListViewDelegate: AnyObject{
    
    func didSelectBook(book: Book)
}
