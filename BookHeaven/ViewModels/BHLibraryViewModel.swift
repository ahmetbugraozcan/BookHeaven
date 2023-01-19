//
//  BHLibraryViewModel.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 19.01.2023.
//

import Foundation
import CoreData

class BHLibraryViewModel{
    var libraryItems: [BHBook] = []
//    var container: NSPersistentContainer!
//
//    init(container: NSPersistentContainer) {
//        self.container = container
//    }
//
    
    
    func getBooksFromCoreData(){
        let cdManager = BHCoreDataManager()
        let data = cdManager.fetch(BHBookCDModel.self)
        
        data.forEach { bookCDModel in
            let book = BHBook.convertCoreDataBookToDomainBook(with: bookCDModel)
            print("data is \(book.title)")
        }
    }
    
    
    
    
}
