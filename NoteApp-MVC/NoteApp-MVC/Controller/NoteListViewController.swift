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
//        noteListDataSource.noteList
        
//        notificationToken = NotificationCenter.default.observer(forName: NoteList.noteListDidChange, using: { (notification) in
        NotificationCenter.default.addObserver(self, selector: #selector(handleNoteListChangeNotification), name: NoteList.changeNotification, object: nil)
        
    }
    
    @IBAction func tapAddNoteBtn(_ sender: UIBarButtonItem) {
        noteList.addNote()
    }

    @objc func handleNoteListChangeNotification() {
        let indexPath = IndexPath(row: 0, section: 0)
        listTableView.insertRows(at: [indexPath], with: .automatic)
    }
}

extension NoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteDetailViewController = instantiate("Main", viewControllerType: NoteDetailViewController.self)
        navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
}

fileprivate extension String {
    static let noteListCell = "NoteListCell"
}
