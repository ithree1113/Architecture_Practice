//
//  Note.swift
//  NoteApp-MVC
//
//  Created by EddieCheng on 2018/12/19.
//  Copyright © 2018 Eddie. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    
    @NSManaged public var imageName: String
    @NSManaged public var sort: Int16
    @NSManaged public var text: String
    
    
    func getImage() -> UIImage? {
        guard !imageName.isEmpty else {
            return nil
        }
        
        let imageURL = MyDirectoryHelper().getMyURL(.myPhoto).appendingPathComponent(imageName)
        
        if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
            return image
        } else {
            return nil
        }
    }
}
