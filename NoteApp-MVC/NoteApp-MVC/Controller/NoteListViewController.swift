//
//  NoteListViewController.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/23.
//  Copyright © 2018 Eddie. All rights reserved.
//

import UIKit

class NoteListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    
    var noteListDataSource: NoteListDataSource!
    var noteList = NoteList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteListDataSource = NoteListDataSource(noteList, cellIdentifier: .noteListCell)
        listTableView.dataSource = noteListDataSource
        listTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoteListChangeNotification(_:)), name: NoteList.changeNotification, object: noteList)
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        noteList.addNote()
    }

    @objc func handleNoteListChangeNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let reason = userInfo[NoteList.changeReason] as? String else {
            return
        }
        
        let index = userInfo[NoteList.index] as? Int
        
        switch (reason, index) {
        case (NoteList.added, _):
            let indexPath = IndexPath(row: 0, section: 0)
            listTableView.insertRows(at: [indexPath], with: .automatic)
            listTableView.reloadData()
        case let (NoteList.deleted, row?):
            listTableView.deleteRows(at: [IndexPath.init(row: row, section: 0)], with: .automatic)
        default:
            break
        }
    }
}

// MARK: - UITableViewDelegate
extension NoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let noteDetailViewController = instantiate("Main", viewControllerType: NoteDetailViewController.self)
        noteDetailViewController.note = noteList.getNote(index: indexPath.row)
        noteDetailViewController.didFinishUpdate = { [weak self] (note) in
            guard let strongSelf = self else {
                return
            }
            if let row = strongSelf.noteList.index(of: note) {
                strongSelf.listTableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            }
        }
        navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
}

fileprivate extension String {
    static let noteListCell = "NoteListCell"
}
