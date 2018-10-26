//
//  ViewController.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/24.
//  Copyright © 2018 Eddie. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func instantiate<T>(_ storyboardID: String, viewControllerType: T.Type) -> T {
        let storyboard = UIStoryboard(name: storyboardID, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: viewControllerType)) as! T
        
        return viewController
    }
    
}
