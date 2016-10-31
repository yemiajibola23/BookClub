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
        sut.book.comments.append(comment)
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), sut.book.comments.count)
    }
    
    func testCellIsCommentTableViewCell() {
        let comment = Comment(text: "Test Comment", username: "User")
        sut.book.comments.append(comment)
        
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is CommentTableViewCell)
    }
    
    func testCellForRowDequeuesCell() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        
        mockTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        
        let comment = Comment(text: "Test Comment", username: "User")
        sut.book.comments.append(comment)
        
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
}

extension CommentListDataProviderTests {
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
}