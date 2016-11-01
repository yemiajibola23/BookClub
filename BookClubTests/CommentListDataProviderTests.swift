//
//  CommentListDataProviderTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class CommentListDataProviderTests: XCTestCase {
    var sut: CommentListDataProvider!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        
        sut = CommentListDataProvider()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookDetailViewController = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        
        
        sut.book = Book(title: "Of Mice and Men", author: "John Steinbeck")
        bookDetailViewController.book = sut.book
        
        _ = bookDetailViewController.view
        
        tableView = bookDetailViewController.commentsTableView
        
        tableView.dataSource = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfCommentsInListIsNumberOfCommentsForBook() {
        
        let comment = Comment(text: "Test Comment", username: "User")
        sut.book.addComment(comment: comment)
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), sut.book.commentsCount)
    }
    
    func testCellIsCommentTableViewCell() {
        let comment = Comment(text: "Test Comment", username: "User")
        sut.book.addComment(comment: comment)
        
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is CommentTableViewCell)
    }
    
    func testCellForRowDequeuesCell() {
       let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        let comment = Comment(text: "Test Comment", username: "User")
        sut.book.addComment(comment: comment)
        
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func testConfigCellGetsCalled() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        let comment = Comment(text: "Test", username: "User")
        sut.book.addComment(comment: comment)
        
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockCell
        
        XCTAssertEqual(comment, cell.commentForCell)
    }
    
}

extension CommentListDataProviderTests {
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableViewWithDataSource(dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
            
            mockTableView.dataSource = dataSource
            
            mockTableView.register(MockCell.self, forCellReuseIdentifier: "CommentCell")
            
            return mockTableView
        }
        
        
    }
    
    class MockCell: CommentTableViewCell {
        var commentForCell: Comment?
        override func configCellWithComment(comment: Comment) {
              commentForCell = comment
        }
    }
}
