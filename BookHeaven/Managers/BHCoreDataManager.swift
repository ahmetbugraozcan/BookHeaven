//
//  BHCoreDataManager.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 16.01.2023.
//

import Foundation
import CoreData
import UIKit

class BHCoreDataManager{
    private let viewContext = (UIApplication.shared.connectedScenes
        .first!.delegate as! SceneDelegate).persistentContainer.viewContext
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do{
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else {return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else {return nil}
        let object = T(entity: entity, insertInto: viewContext)
        return object
        
    }
    
    func saveContext(){
     
        guard viewContext.hasChanges else {return}
        do{
            try viewContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
