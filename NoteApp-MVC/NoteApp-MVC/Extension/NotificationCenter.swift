//
//  NotificationCenter.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/26.
//  Copyright © 2018 Eddie. All rights reserved.
//

import Foundation

extension NotificationCenter {
    func addObserver(name: Notification.Name, object: Any? = nil, queue: OperationQueue = .main, using: @escaping ((Notification) -> Void)) -> NotificationToken {
        
        let token = addObserver(forName: name, object: object, queue: queue, using: using)
        
        return NotificationToken(token)
    }
}
