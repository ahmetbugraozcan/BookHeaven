//
//  Book.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import Foundation

// MARK: - Book
struct Book: Codable, Identifiable {
    let bookID: Int?
    let id: String = UUID().uuidString
    let formats: Formats
    let title: String?
    let authors, translators: [Author]?
    let subjects, bookshelves: [String]?
    let languages: [Language]?
    let copyright: Bool?
    let downloadCount: Int?

    enum CodingKeys: String, CodingKey {
        case bookID = "id", title, authors, translators, subjects, bookshelves, languages, copyright, formats
        case downloadCount = "download_count"
    }
    
    
}


extension Array where Element == Book {
    func indexOfBooks(with id: Book.ID) -> Self.Index{
        guard let index = firstIndex(where: {$0.id == id}) else {
            fatalError()
        }
        return index
    }
}


enum Language: String, Codable {
    case en = "en"
    case tl = "tl"
    case zh = "zh"
}

extension Language {
    
    func getFullName()->String{
        switch self{
        case .en:
            return "English"
        case .tl:
            return "tl"
        case .zh:
            return "zh"
        }
    }
}
