//
//  StoryboardTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class StoryboardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHomeViewControllerIsIntitialViewController() {
        let sut = UIStoryboard(name: "Main", bundle: nil)
        
        let rootViewController = sut.instantiateInitialViewController() as! UINavigationController
        
        let homeViewController = rootViewController.viewControllers.first
        
        XCTAssertTrue(homeViewController is HomeViewController)
    }
    
}
