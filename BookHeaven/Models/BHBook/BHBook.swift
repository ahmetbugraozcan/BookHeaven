//
//  Book.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import Foundation

// MARK: - Book
struct BHBook: Codable, Identifiable {
    let bookID: Int?
    let id: String = UUID().uuidString
    let formats: BHFormats
    let title: String?
    let authors, translators: [BHAuthor]?
    let subjects, bookshelves: [String]?
    let languages: [String]?
    let copyright: Bool?
    let downloadCount: Int?

    enum CodingKeys: String, CodingKey {
        case bookID = "id", title, authors, translators, subjects, bookshelves, languages, copyright, formats
        case downloadCount = "download_count"
    }

    
}

extension BHBook {

    
    func getLanguageReadableName() -> String{
        guard let language = self.languages?.first else {
            return "Unknown"
        }
        
        return Locale.current.localizedString(forLanguageCode: language) ?? "Unknown"
    }
}

extension Array where Element == BHBook {
    func indexOfBooks(with id: BHBook.ID) -> Self.Index{
        guard let index = firstIndex(where: {$0.id == id}) else {
            fatalError()
        }
        return index
    }
}


//enum Language: String, Codable {
//    case en = "en"
//    case tl = "tl"
//    case zh = "zh"
//    case de = "de"
//}
//
//extension Language {
//    
//    func getFullName()->String{
//        switch self{
//        case .en:
//            return "English"
//        case .tl:
//            return "tl"
//        case .zh:
//            return "zh"
//        case .de:
//            return "de"
//
//        }
//    
//    }
//}
