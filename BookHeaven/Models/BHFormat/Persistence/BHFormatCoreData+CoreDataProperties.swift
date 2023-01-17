//
//  BHFormatCoreData+CoreDataProperties.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//
//

import Foundation
import CoreData


extension BHFormatCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BHFormatCoreData> {
        return NSFetchRequest<BHFormatCoreData>(entityName: "BHFormatCoreData")
    }

    @NSManaged public var applicationEpubZip: String?
    @NSManaged public var applicationOctetStream: String?
    @NSManaged public var applicationRDFXML: String?
    @NSManaged public var applicationXMobipocketEbook: String?
    @NSManaged public var imageJPEG: String?
    @NSManaged public var textHTML: String?
    @NSManaged public var textPlain: String?
    @NSManaged public var textPlainCharsetUsASCII: String?
    @NSManaged public var book: BHBookCDModel?

}

extension BHFormatCoreData : Identifiable {

}
