//
//  LibraryAPIClientTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 11/1/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class LibraryAPIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLibrarySearchURLReturnsValidURL() {
        //let sut = LibraryAPIClient()
        
        let url = LibraryAPIClient.searchItemURL(query: "bladj;afjf;")
        
        let application = UIApplication.shared
        
        XCTAssertTrue(application.canOpenURL(url))
    }
    
}
