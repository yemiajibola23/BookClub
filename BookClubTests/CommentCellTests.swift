//
//  CommentCellTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/31/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class CommentCellTests: XCTestCase {
    var cell: CommentTableViewCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        
        let book = Book(title: "Of Mice and Men", author: "John Steinbeck")
        controller.book = book
        
        _ = controller.view
        
        let tableView = controller.commentsTableView
        let fakeDataSource = FakeDataSource()
        tableView!.dataSource = fakeDataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: "CommentCell", for: IndexPath(row: 0, section: 0)) as! CommentTableViewCell
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testCommentCellHasLabels() {
        
        XCTAssertNotNil(cell.commentTextLabel)
        XCTAssertNotNil(cell.commentUserLabel)
        
    }
    
    func testCommentCellHasDetails() {
        let comment = Comment(text: "Test Comment", username: "User")
        cell.configCellWithComment(comment: comment)
        
        
        XCTAssertEqual(comment.text, cell.commentTextLabel.text)
        XCTAssertEqual(comment.username, cell.commentUserLabel.text)
    }
    
}

extension CommentCellTests {
    class FakeDataSource:NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    }
}
