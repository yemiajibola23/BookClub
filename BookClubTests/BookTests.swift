//
//  BookTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/27/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class BookTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
   
    func testBookHasTitleAndAuthor() {
        let book = Book(title: "Of Mice And Men", author: "John Steinbeck")
        
        XCTAssertEqual(book.title, "Of Mice And Men")
        XCTAssertEqual(book.author, "John Steinbeck")
    }
    
}
