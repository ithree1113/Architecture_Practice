//
//  Note.swift
//  NoteApp-MVC
//
//  Created by EddieCheng on 2018/12/19.
//  Copyright © 2018 Eddie. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    
    @NSManaged public var imageName: String
    @NSManaged public var sort: Int16
    @NSManaged public var text: String
}
