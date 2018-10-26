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
     This a method that inserts data form a specific entity.
     
     - Parameter theEntityName: A specific entity name.
     - Parameter attributeInfo: A dictionary to insert, such as [attribute name: value].
     - Returns: The NSManagedObject just inserting.
     */
    func insert(_ theEntityName: String, attributeInfo: [String: String]?) -> NSManagedObject {
        
        let insertData = NSEntityDescription.insertNewObject(forEntityName: theEntityName, into: context)
        
        if let attribute = attributeInfo {
            for(key, value) in attribute {
                let type = insertData.entity.attributesByName[key]?.attributeType
                
                // According the type to translate the data format of value.
                if (type == .integer16AttributeType ||
                    type == .integer32AttributeType ||
                    type == .integer64AttributeType) {
                    insertData.setValue(Int(value), forKey: key)
                } else if (type == .floatAttributeType ||
                    type == .doubleAttributeType) {
                    insertData.setValue(Double(value), forKey: key)
                } else if (type == .booleanAttributeType) {
                    insertData.setValue((value == "true" ? true : false), forKey: key)
                } else if (type == .stringAttributeType) {
                    insertData.setValue(value, forKey: key)
                }
            }
        }
        
//        self.save()
        
        return insertData
    }
    
}
