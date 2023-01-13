//
//  BHBooksDetailViewModel.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 11.01.2023.
//

import Foundation

final class BHBooksDetailViewModel{
    var book: BHBook
    
    init(_ book: BHBook) {
        self.book = book
    }
    
    func getBookDetails(completion: @escaping (Result<BHEBookDetail, Error>) -> Void){
        guard let title = book.title else {
            return
        }
        
        BHService.shared.request(request: BHService.getBookDetailsRequest(with: title), expected: BHBookDetailsResponse.self) { result in
            switch result {
            case .success(let itemsResponse):
                guard let item = itemsResponse.items.first else {
                    completion(.failure(NSError()))
                    return
                }
                completion(.success(item))
                
            case .failure(let failure):
                completion(.failure(failure))
                print(String(describing: failure))
            }
        }
    }
}
