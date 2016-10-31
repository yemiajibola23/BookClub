//
//  BookCellTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class BookCellTests: XCTestCase {
    var tableView: UITableView!
    var cell: BookTableViewCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        _ = controller.view
        tableView = controller.bookTableView
        let fakeDataSource = FakeDataSource()
        tableView!.dataSource = fakeDataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: "BookCell", for: IndexPath(row: 0, section: 0)) as! BookTableViewCell
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testCellHasAuthorLabel() {
        XCTAssertNotNil(cell.authorLabel)
    }
    
    func testLabelsHasBookTitleAndAuthor() {
        let bookForCell = Book(title: "Of Mice And Men", author: "John Steinbeck")
        
        cell.configCellWithBook(book: bookForCell)
        
        XCTAssertEqual("Of Mice And Men", cell.titleLabel.text)
        
        XCTAssertEqual(cell.authorLabel.text, "John Steinbeck")
    }
    
}

extension BookCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
