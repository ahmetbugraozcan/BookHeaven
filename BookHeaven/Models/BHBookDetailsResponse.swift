//
//  BHBookDetailsResponse.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 12.01.2023.
//

import Foundation


struct BHBookDetailsResponse: Codable{
    let kind: String
    let totalItems: Int
    let items: [BHEBookDetail]
    
    
}
