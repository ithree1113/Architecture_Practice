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
    static let changeReason = "reason"
    static let added = "added"
    static let deleted = "deleted"
    static let index = "index"
    
    private var notes: [Note] = []
    
    var count: Int {
        return notes.count
    }
    
    func getNote(index: Int) -> Note {
        return notes[index]
    }
    
    func addNote() {
        notes.insert(Note(), at: 0)
        
        let userInfo = [NoteList.changeReason: NoteList.added]
        
        NotificationCenter.default.post(name: NoteList.changeNotification, object: self, userInfo: userInfo)
    }
    
    func deleteNote(_ index: Int) {
        notes.remove(at: index)
        
        let userInfo = [NoteList.changeReason: NoteList.deleted, NoteList.index: index] as [String : Any]
        
        NotificationCenter.default.post(name: NoteList.changeNotification, object: self, userInfo: userInfo)
    }
    
}


