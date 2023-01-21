//
//  BHCoreDataManager.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 16.01.2023.
//

import Foundation
import CoreData
import UIKit

final class BHCoreDataManager{
    private struct FetchRequest<T>{
        let type: T.Type
        let id: Int
        let field: String
    }
    
    static let shared = BHCoreDataManager()
    
//    private init(){
//        var results = fetch(BHBookCDModel.self)
//
//        results.forEach { bhbookmodel in
//            print("bookmodel title is \(bhbookmodel.id)")
//        }
//    }
//
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
    
    func fetchItemByCustomId<T: NSManagedObject>(expected type: T.Type, with id: Int?, whereField: String) -> T?{
        guard let id = id else {return nil}
        let fetch = T.fetchRequest()
        let predicate = NSPredicate(format: "\(whereField) == %i", id)
        fetch.predicate = predicate
        fetch.fetchLimit = 1

        do{
             viewContext.reset()
            

            let result = try viewContext.fetch(fetch)
 
            for data in result as! [NSManagedObject] {
                 print(data.value(forKey: "title") as! String)
               }
            return result.first as? T
            
        } catch {
            print("Failed")
            return nil
        }
    }
    
    func deleteItemByCustomId<T:NSManagedObject>(expected type: T.Type, id: Int?, whereField: String) -> Bool{
        guard id != nil else {
            return false
        }
        
        guard let item = fetchItemByCustomId(expected: T.self, with: id, whereField: whereField) else {
            return false
        }
        
        viewContext.delete(item)
        
        do {
            try saveContext()
        } catch {
            return false
        }
        
        return true
    }
    
    func saveContext() throws{
        guard viewContext.hasChanges else {return}
        do{
            try viewContext.save()
//            viewContext.refreshAllObjects()

        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
            throw error
        }
    }
}
