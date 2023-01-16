//
//  BHBookCDModel+CoreDataProperties.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//
//

import Foundation
import CoreData


extension BHBookCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BHBookCDModel> {
        return NSFetchRequest<BHBookCDModel>(entityName: "BHBookCDModel")
    }

    @NSManaged public var bookID: Int64
    @NSManaged public var bookshelves: [String]?
    @NSManaged public var copyright: Bool
    @NSManaged public var downloadCount: Int64
    @NSManaged public var id: String?
    @NSManaged public var languages: [String]?
    @NSManaged public var subjects: [String]?
    @NSManaged public var testtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var formats: BHFormatCoreData?

}

extension BHBookCDModel : Identifiable {

}
extension BHBookCDModel {
    func coreDataFromBHBook(with book: BHBook)  {
        var coreDataManager = BHCoreDataManager()
//        self.authors = NSSet(array: book.authors ?? [])
//        self.translators = NSSet(array: book.translators ?? [])
        self.id = book.id
        self.title = book.title
        self.downloadCount = Int64(book.downloadCount ?? 0)
        self.subjects = book.subjects
        self.copyright = book.copyright ?? false
        self.bookshelves = book.bookshelves
        
     
        var formats = coreDataManager.add(BHFormatCoreData.self)
        formats?.textHTML = book.formats.textHTML
        formats?.textPlain = book.formats.textPlain
        formats?.imageJPEG = book.formats.imageJPEG
        formats?.textPlainCharsetUsASCII = book.formats.textPlainCharsetUsASCII
        formats?.applicationXMobipocketEbook = book.formats.applicationXMobipocketEbook
        formats?.applicationOctetStream = book.formats.applicationOctetStream
        formats?.applicationRDFXML = book.formats.applicationRDFXML
        formats?.applicationEpubZip = book.formats.applicationEpubZip
            
        self.formats = formats
        
  

        
    }
}
