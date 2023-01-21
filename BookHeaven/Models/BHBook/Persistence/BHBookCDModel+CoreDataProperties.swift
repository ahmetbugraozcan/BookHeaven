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
    @NSManaged public var authors: NSSet?
    @NSManaged public var formats: BHFormatCoreData?
    @NSManaged public var translators: NSSet?
    
}

// MARK: Generated accessors for authors
extension BHBookCDModel {
    
    @objc(addAuthorsObject:)
    @NSManaged public func addToAuthors(_ value: BHAuthorCoreData)
    
    @objc(removeAuthorsObject:)
    @NSManaged public func removeFromAuthors(_ value: BHAuthorCoreData)
    
    @objc(addAuthors:)
    @NSManaged public func addToAuthors(_ values: NSSet)
    
    @objc(removeAuthors:)
    @NSManaged public func removeFromAuthors(_ values: NSSet)
    
}

// MARK: Generated accessors for translators
extension BHBookCDModel {
    
    @objc(addTranslatorsObject:)
    @NSManaged public func addToTranslators(_ value: BHAuthorCoreData)
    
    @objc(removeTranslatorsObject:)
    @NSManaged public func removeFromTranslators(_ value: BHAuthorCoreData)
    
    @objc(addTranslators:)
    @NSManaged public func addToTranslators(_ values: NSSet)
    
    @objc(removeTranslators:)
    @NSManaged public func removeFromTranslators(_ values: NSSet)
    
}

extension BHBookCDModel : Identifiable {
    
}

extension BHBookCDModel {
    func coreDataFromBHBook(with book: BHBook)  {
        var coreDataManager = BHCoreDataManager.shared
        //        self.authors = NSSet(array: book.authors ?? [])
        //        self.translators = NSSet(array: book.translators ?? [])
        self.id = book.id
        self.title = book.title
        self.downloadCount = Int64(book.downloadCount ?? 0)
        self.subjects = book.subjects
        self.copyright = book.copyright ?? false
        self.bookshelves = book.bookshelves
        self.bookID = Int64(book.bookID ?? 0)
        
        var formats = coreDataManager.add(BHFormatCoreData.self)
        formats?.textHTML = book.formats.textHTML
        formats?.textPlain = book.formats.textPlain
        formats?.imageJPEG = book.formats.imageJPEG
        formats?.textPlainCharsetUsASCII = book.formats.textPlainCharsetUsASCII
        formats?.applicationXMobipocketEbook = book.formats.applicationXMobipocketEbook
        formats?.applicationOctetStream = book.formats.applicationOctetStream
        formats?.applicationRDFXML = book.formats.applicationRDFXML
        formats?.applicationEpubZip = book.formats.applicationEpubZip
        self.languages = book.languages
        
        
       
            book.authors?.forEach({ bookAuthor in
                guard let author = coreDataManager.add(BHAuthorCoreData.self), bookAuthor != nil else {return}
                author.name = bookAuthor!.name
                author.deathYear = Int16(bookAuthor!.deathYear ?? 0)
                author.birthYear = Int16(bookAuthor!.birthYear ?? 0)
                self.addToAuthors(author)
            })
            
            book.translators?.forEach({ bookAuthor in
                guard let author = coreDataManager.add(BHAuthorCoreData.self), bookAuthor != nil else {return}
                author.name = bookAuthor!.name
                author.deathYear = Int16(bookAuthor!.deathYear ?? 0)
                author.birthYear = Int16(bookAuthor!.birthYear ?? 0)
                self.addToAuthors(author)
            })
        
        
        
        self.formats = formats
        
    }
}
