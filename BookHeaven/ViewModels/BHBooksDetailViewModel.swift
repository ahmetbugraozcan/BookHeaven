//
//  BHBooksDetailViewModel.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 11.01.2023.
//

import Foundation

class BHBooksDetailViewModel{
    var book: BHBook
    
    init(_ book: BHBook) {
        self.book = book
        getBookDetails(book: book)
    }
    
    func getBookDetails(book: BHBook){
        guard let title = book.title else {
            return
        }
        
        BHService.shared.request(request: BHService.getBookDetailsRequest(with: title), expected: BHBookDetailsResponse.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success.items.first))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
