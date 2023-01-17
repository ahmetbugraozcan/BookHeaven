//
//  BHAuthorCoreData+CoreDataProperties.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//
//

import Foundation
import CoreData


extension BHAuthorCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BHAuthorCoreData> {
        return NSFetchRequest<BHAuthorCoreData>(entityName: "BHAuthorCoreData")
    }

    @NSManaged public var birthYear: Int16
    @NSManaged public var deathYear: Int16
    @NSManaged public var name: String?
    @NSManaged public var authors: BHBookCDModel?
    @NSManaged public var translators: BHBookCDModel?

}

extension BHAuthorCoreData : Identifiable {

}
