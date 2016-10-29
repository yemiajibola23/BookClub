//
//  ReaderTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class ReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testReaderNameMatches() {
        let name = "Fred"
        let sut = Reader(name: name)
        
        XCTAssertEqual(sut.name, name)
    }
    
    func testAddBookIncrementsReadBookCount() {
        let sut = Reader(name: nil)
        let book = Book(title: "Of Mice And Men", author: "John Steinbeck")
        sut.addBook(book: book)
        
        XCTAssertEqual(sut.readBooksCount, 1)
    }
    
    func testAddBookAddsCorrectBook() {
        let sut = Reader(name: nil)
        let book = Book(title: "Of Mice And Men", author: "John Steinbeck")
        sut.addBook(book: book)
        
        let returnedBook = sut.bookAt(index: 0)
        
        XCTAssertEqual(book.title, returnedBook.title)
    }
    
    func testRemoveBookDecrementsReadBookCount() {
        let sut = Reader(name: nil)
        let book = Book(title: "Of Mice And Men", author: "John Steinbeck")
        sut.addBook(book: book)
        
        let _ = sut.removeBookAt(index: 0)
        
        XCTAssertEqual(sut.readBooksCount, 0)
    }
    
    func testRemoveBookRemovesCorrectBook() {
        let sut = Reader(name: nil)
        let book = Book(title: "Of Mice And Men", author: "John Steinbeck")
        sut.addBook(book: book)
        
        let deletedBook = sut.removeBookAt(index: 0)
        
        XCTAssertEqual(deletedBook.author, book.author)
    }
    
}
