//
//  BookListDataProviderTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class BookListDataProviderTests: XCTestCase {
    
    var sut: BookListDataProvider!
    var tableView: UITableView!
    var controller: HomeViewController!
    var reader: Reader!
    
    override func setUp() {
        super.setUp()
        
        sut = BookListDataProvider()
        sut.reader = Reader(name: "Fred")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let _ = controller.view
        
        tableView = controller.bookTableView
        
        tableView.dataSource = sut
        tableView.delegate = sut
    
        reader = sut.reader
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfItemsInListIsReadBookCount() {
        reader.addBook(book: Book(title: "Of Mice And Men", author: "John Steinbeck"))
        
       XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
    }
    
    func testCellForItemReturnsBookCell() {
        reader.addBook(book: Book(title: "Of Mice And Men", author: "John Steinbeck"))
        tableView.reloadData()
        
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        
        XCTAssertTrue(cell is BookTableViewCell)
    }
    
    func testBookCellForRowDequeuesCell() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        mockTableView.register(MockBookCell.self, forCellReuseIdentifier: "BookCell")
        
        reader.addBook(book: Book(title: "Of Mice And Men", author: "John Steinbeck"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func testConfigCellGetsCalledInCellForRow() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        mockTableView.dataSource = sut
        mockTableView.register(MockBookCell.self, forCellReuseIdentifier: "BookCell")
        
        let book = Book(title: "Of Mice And Men", author: "John Steinbeck")
        reader.addBook(book: book)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockBookCell
        
        XCTAssertEqual(cell.bookForCell!, book)
    }
    
}

extension BookListDataProviderTests {
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableViewWithDataSource(dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
            mockTableView.dataSource = dataSource
            mockTableView.register(MockBookCell.self, forCellReuseIdentifier: "BookCell")
            
            return mockTableView
        }
    }
    
    class MockBookCell: BookTableViewCell {
        var bookForCell: Book?
        
        override func configCellWithBook(book: Book) {
            bookForCell = book
        }
    }
    
}




