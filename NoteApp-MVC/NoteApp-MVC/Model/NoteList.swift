//
//  NoteList.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/26.
//  Copyright © 2018 Eddie. All rights reserved.
//

import UIKit

class NoteList {
    
    static let changeNotification = Notification.Name("NoteListDidChange")
    private var noteList: [Note] = []
    
    var count: Int {
        return noteList.count
    }
    
    func getNote(index: Int) -> Note {
        return noteList[index]
    }
    
    func addNote() {
        noteList.insert(Note(), at: 0)
        
        NotificationCenter.default.post(name: NoteList.changeNotification, object: nil, userInfo: nil)
    }
    
}

//extension Notification.Name {
//    public static let NoteListDidChange: Notification.Name
//}
