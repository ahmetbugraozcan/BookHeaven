//
//  BHBookCDModel+CoreDataProperties.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 16.01.2023.
//
//

import Foundation
import CoreData


extension BHBookCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BHBookCDModel> {
        return NSFetchRequest<BHBookCDModel>(entityName: "BHBookCDModel")
    }

    @NSManaged public var bookID: Int64
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var subjects: [String]?
    @NSManaged public var bookshelves: [String]?
    @NSManaged public var copyright: Bool
    @NSManaged public var languages: [String]?
    @NSManaged public var downloadCount: Int64
    @NSManaged public var testTitle: String

}

extension BHBookCDModel : Identifiable {

}

extension BHBookCDModel {
    func coreDataFromBHBook(with book: BHBook)  {
//        self.authors = NSSet(array: book.authors ?? [])
//        self.translators = NSSet(array: book.translators ?? [])
        self.id = book.id
        self.title = book.title
        self.downloadCount = Int64(book.downloadCount ?? 0)
        self.subjects = book.subjects
        self.copyright = book.copyright ?? false
        self.bookshelves = book.bookshelves
        
        self.testTitle = "TEST"
        
    }
}
