//
//  BHPersistentContainer.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 15.01.2023.
//

import CoreData


class PersistentContainer: NSPersistentContainer {
    func saveContext(backgroundContext: NSManagedObjectContext? = nil){
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else {return}
        do{
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
