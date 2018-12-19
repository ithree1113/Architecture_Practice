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
    
    private var notes: [Note]
    
    var count: Int {
        return notes.count
    }
    
    init() {
        notes = CoreData.shared.load(.noteEntity, sort: [.sortKey: false]) ?? []
    }
    
    func getNote(index: Int) -> Note {
        return notes[index]
    }
    
    func index(of note: Note) -> Int? {
        return notes.firstIndex(of: note)
    }
    
    func addNote() {
        
        let note: Note = CoreData.shared.insert(.noteEntity, attributeInfo: [.textKey: "New Note", .sortKey: getSort()])
        
        notes.insert(note, at: 0)
        
        let userInfo = [NoteList.changeReason: NoteList.added]
        
        NotificationCenter.default.post(name: NoteList.changeNotification, object: self, userInfo: userInfo)
    }
    
    func deleteNote(_ index: Int) {
        
        CoreData.shared.delete(selectedData: notes.remove(at: index))
        
        let userInfo = [NoteList.changeReason: NoteList.deleted, NoteList.index: index] as [String : Any]
        
        NotificationCenter.default.post(name: NoteList.changeNotification, object: self, userInfo: userInfo)
    }
}

extension NoteList {
    func getSort() -> Int {
        var sort = 0
        if let lastSort = UserDefaults.standard.value(forKey: .lastSort) as? Int {
            sort = lastSort + 1
        }
        UserDefaults.standard.set(sort, forKey: .lastSort)
        return sort
    }
}


fileprivate extension String {
    static let lastSort = "lastSort"
    
    static let noteEntity = "Note"
    static let textKey = "text"
    static let sortKey = "sort"
}

