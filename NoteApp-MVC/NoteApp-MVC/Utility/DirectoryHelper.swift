//
//  DirectoryHelper.swift
//  NoteApp-MVC
//
//  Created by EddieCheng on 2018/12/25.
//  Copyright © 2018 Eddie. All rights reserved.
//

import Foundation

class DirectoryHelper {
    static let myHomePath: String = NSHomeDirectory()
    
    static let myHomeURL: URL = URL(fileURLWithPath: "\(NSHomeDirectory())")
    
    static let myDocumentsPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    static let myDocumentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}


class MyDirectoryHelper: DirectoryHelper {
    enum MyDirectory : String {
        case myPhoto = "Photo"
    }
    
    func getMyPath(_ myDirectory: MyDirectory) -> String {
        
        var resultPath: String
        
        switch myDirectory {
        case .myPhoto:
            resultPath = DirectoryHelper.myDocumentsPath.appending("/\(myDirectory.rawValue)")
            break
        }
        
        if !(FileManager.default.fileExists(atPath: resultPath)) {
            do {
                let resultURL = URL(fileURLWithPath: resultPath)
                try FileManager.default.createDirectory(at: resultURL, withIntermediateDirectories: false, attributes: nil)
            } catch  {
                print(error)
            }
        }
        return resultPath
    }
    
    func getMyURL(_ myDirectory: MyDirectory) -> URL {
        return URL(fileURLWithPath: self.getMyPath(myDirectory))
    }
}
