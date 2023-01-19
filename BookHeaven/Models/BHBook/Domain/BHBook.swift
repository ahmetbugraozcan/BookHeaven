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
    let authors, translators: [BHAuthor?]?
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
    
    static func convertCoreDataBookToDomainBook(with book: BHBookCDModel) -> Self {
        
        let title = book.title
        let bookID = book.bookID
        let bookshelves = book.bookshelves
        let downloadCount = book.downloadCount
        let copyright = book.copyright
        let id = book.id
        let languages = book.languages
        let subjects = book.subjects
        let translators:[BHAuthor?] = book.translators!.compactMap({ translator in
            guard let translator = translator as? BHAuthorCoreData else {
                return nil
            }
            let translatorElement = BHAuthor(name: translator.name, birthYear: Int(translator.birthYear), deathYear: Int(translator.deathYear))
            return translatorElement
        })
        
        let authors:[BHAuthor?] = book.authors!.compactMap({ translator in
            guard let translator = translator as? BHAuthorCoreData else {
                return nil
            }
            let translatorElement = BHAuthor(name: translator.name, birthYear: Int(translator.birthYear), deathYear: Int(translator.deathYear))
            return translatorElement
        })
        
        let format = BHFormats(textPlain: book.formats?.textPlain, applicationXMobipocketEbook: book.formats?.applicationXMobipocketEbook, textHTML: book.formats?.textHTML, applicationOctetStream: book.formats?.applicationOctetStream, textPlainCharsetUsASCII: book.formats?.textPlainCharsetUsASCII, applicationEpubZip: book.formats?.applicationEpubZip, imageJPEG: book.formats?.imageJPEG, applicationRDFXML: book.formats?.applicationRDFXML)
        
        let book = BHBook(bookID: Int(bookID), formats: format, title: title, authors: authors, translators: translators, subjects: subjects, bookshelves: bookshelves, languages: languages, copyright: copyright, downloadCount: Int(downloadCount))
        
        return book
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
