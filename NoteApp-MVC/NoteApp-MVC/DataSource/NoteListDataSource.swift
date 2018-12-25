//
//  NoteListDataSource.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/23.
//  Copyright © 2018 Eddie. All rights reserved.
//

import UIKit


class NoteListDataSource: NSObject, UITableViewDataSource {
    
    var noteList: NoteList!
    var indentifier: String
    
    init(_ noteList: NoteList, cellIdentifier: String) {
        self.noteList = noteList
        self.indentifier = cellIdentifier
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)
        
        cell.config(with: noteList.getNote(index: indexPath.row))
//        cell.config(with: noteList[indexPath.row])
//        cell.config(with: nil)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if case .delete = editingStyle {
            noteList.deleteNote(indexPath.row)
        }
    }
}


fileprivate extension UITableViewCell {
    func config(with note: Note) {
        textLabel?.text = note.text
        imageView?.image = note.getImage()
    }
}
