//
//  NotificationToken.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/26.
//  Copyright © 2018 Eddie. All rights reserved.
//

import Foundation

class NotificationToken {
    var token: NSObjectProtocol!
    
    init(_ token: NSObjectProtocol) {
        self.token = token
    }
    
    deinit {
        NotificationCenter.default.removeObserver(token)
    }
}
