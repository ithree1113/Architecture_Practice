//
//  Note.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/25.
//  Copyright © 2018 Eddie. All rights reserved.
//

import Foundation

class Note: Equatable {
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.text == rhs.text && lhs.imageName == rhs.imageName && lhs.sort == rhs.sort
    }
    
    var text: String = "New Note"
    var imageName: String = ""
    var sort: Int = 0
    
    init() {
        if let lastSort = UserDefaults.standard.value(forKey: .lastSort) as? Int {
            sort = lastSort + 1
        }
        UserDefaults.standard.set(sort, forKey: .lastSort)
    }
    
}



fileprivate extension String {
    static let lastSort = "LastSort"
}
