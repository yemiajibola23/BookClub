//
//  HomeViewControllerTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class HomeViewControllerTests: XCTestCase {
    var sut: HomeViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        sut = homeViewController
        let _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.bookTableView)
    }
    
}
