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
    var notificationToken: NotificationToken!
//        didSet {
//            noteListDataSource.noteList = noteList
//            if noteList.count > oldValue.count {
//                let indexPath = IndexPath(row: 0, section: 0)
//                listTableView.insertRows(at: [indexPath], with: .automatic)
//            } else {
//
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteListDataSource = NoteListDataSource(noteList, cellIdentifier: .noteListCell)
        listTableView.dataSource = noteListDataSource
        listTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoteListChangeNotification(_:)), name: NoteList.changeNotification, object: noteList)
    }
    
    @IBAction func tapAddNoteBtn(_ sender: UIBarButtonItem) {
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

extension NoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let noteDetailViewController = instantiate("Main", viewControllerType: NoteDetailViewController.self)
        navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
}

fileprivate extension String {
    static let noteListCell = "NoteListCell"
}
