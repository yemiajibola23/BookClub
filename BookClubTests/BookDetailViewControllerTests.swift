//
//  BookDetailViewControllerTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class BookDetailViewControllerTests: XCTestCase {
    
    var controller: BookDetailViewController!
    var book: Book!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        
        book = Book(title: "Of Mice And Men", author: "John Steinbeck")
        controller.book = book
        
        _ = controller.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBookDetailHasBookInfo() {
        XCTAssertEqual(book.title, controller.navigationItem.title)
        XCTAssertEqual(book.author, controller.authorLabel.text)
    }
    
}
