//
//  NoteApp_MVCTests.swift
//  NoteApp-MVCTests
//
//  Created by ithree on 2018/10/23.
//  Copyright © 2018 Eddie. All rights reserved.
//

import XCTest
@testable import NoteApp_MVC

class NoteApp_MVCTests: XCTestCase {

    var noteListViewController: NoteListViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: NoteListViewController = storyboard.instantiateViewController(withIdentifier: "NoteListViewController") as! NoteListViewController
        noteListViewController = vc
        _ = noteListViewController.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        noteListViewController = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let aa = noteListViewController.noteList.count
        
        noteListViewController.tapAddNoteBtn(UIBarButtonItem())
        
        XCTAssertEqual(aa + 1, noteListViewController.noteList.count)
    }
    
    
    

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
