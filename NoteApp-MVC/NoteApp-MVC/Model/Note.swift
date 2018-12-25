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
    
    func getThumbnailImage(size: CGSize) -> UIImage? {
        guard let image = getImage() else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        let widthRatio  = size.width  / image.size.width
        let heightRatio = size.height / image.size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        
        let newSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        let newOrigin = CGPoint(x: (size.width - newSize.width)/2, y: (size.height - newSize.height)/2)
        
        image.draw(in: CGRect(origin: newOrigin, size: newSize))
        let thumbnailImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return thumbnailImage
    }
}
