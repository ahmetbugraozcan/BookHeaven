//
//  Book.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import Foundation

struct BHAllBooksResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [BHBook]?
}
