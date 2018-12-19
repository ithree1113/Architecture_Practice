//
//  CoreData.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/24.
//  Copyright © 2018 Eddie. All rights reserved.
//

import UIKit
import CoreData

class CoreData {
    static var shared = CoreData()
    
    private var context: NSManagedObjectContext
    
    private init() {
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
 
    /**
     This a method that saves data after a modification.
     
     */
    func save() {
        do {
            try context.save()
        } catch  {
            fatalError("\(error)")
        }
    }
    
    /**
     This a method that inserts data form a specific entity.
     
     - Parameter entityName: A specific entity name.
     - Parameter attributeInfo: A dictionary to insert, such as [attribute name: value].
     - Returns: The NSManagedObject just inserting.
     */
    func insert<T>(_ entityName: String, attributeInfo: [String: Any]? = nil) -> T {
        
        let insertData = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        
        if let attribute = attributeInfo {
            for(key, value) in attribute {
                if let attributeType = insertData.entity.attributesByName[key]?.attributeType {
                    // According the type to translate the data format of value.
                    switch attributeType {
                    case .integer16AttributeType, .integer32AttributeType, .integer64AttributeType:
                        insertData.setValue((value as! Int), forKey: key)
                    case .floatAttributeType:
                        insertData.setValue((value as! Float), forKey: key)
                    case .doubleAttributeType:
                        insertData.setValue((value as! Double), forKey: key)
                    case .booleanAttributeType:
                        insertData.setValue((value as! Bool), forKey: key)
                    case .stringAttributeType:
                        insertData.setValue((value as! String), forKey: key)
                    default:
                        break
                    }
                }
            }
        }
        
        save()
        
        return insertData as! T
    }
    
    /**
     This a method that loads data form a specific entity with some condictions.
     
     - Parameter entityName: A specific entity name.
     - Parameter predicate: The specfic condiction of some attributes.
     - Parameter sort: A dictionary to sort, such as [attribute name: ascending].
     - Parameter limit: The limit of searching results.
     - Returns: A array of searching results.
     */
    func load<T>(_ entityName: String, predicate: String = "", sort: [String: Bool] = [:], limit: Int = 0) -> [T]? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        if !predicate.isEmpty {
            request.predicate = NSPredicate(format: predicate)
        }
        
        if sort.count > 0 {
            var sortArr: [NSSortDescriptor] = []
            for (key, value) in sort {
                sortArr.append(NSSortDescriptor(key: key, ascending: value))
            }
            request.sortDescriptors = sortArr
        }
        
        if limit > 0 {
            request.fetchLimit = limit
        }
        
        do {
            return try self.context.fetch(request) as? [T]
        } catch  {
            fatalError("\(error)")
        }
    }
    
    /**
     This a method that deletes data directly.
     
     - Parameter selectedData: The data that needed to be deleted.
     */
    func delete(selectedData: NSManagedObject) {
        context.delete(selectedData)
        save()
    }
    
    /**
     This a method that deletes data form a specific entity with a predication.
     
     - Parameter entityName: A specific entity name.
     - Parameter predicate: The specfic condiction of some attributes.
     */
    func delete(_ entityName: String, predicate: String) {
        if let results: [NSManagedObject] = load(entityName, predicate: predicate) {
            for result in results {
                context.delete(result)
            }
            save()
        }
    }
}
