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
    private var notes: [Note] = []
    
    var count: Int {
        return notes.count
    }
    
    func getNote(index: Int) -> Note {
        return notes[index]
    }
    
    func addNote() {
        notes.insert(Note(), at: 0)
        
        NotificationCenter.default.post(name: NoteList.changeNotification, object: self, userInfo: nil)
    }
    
}
