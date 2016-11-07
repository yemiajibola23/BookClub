//
//  BookDetailViewController.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BookDetailViewController: UIViewController {
    var book: Book!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var commentListDataProvider: CommentListDataProvider!
    
    override func viewDidLoad() {
        navigationItem.title = book.title
        authorLabel.text = book.author
        commentListDataProvider.book = book
        
        commentsTableView.dataSource = commentListDataProvider
        
        fetchComments()
    }
    
    func fetchComments() {
        var commmentsToAdd:[Comment] = []
        
        book.ref?.child("comments").observe(.value, with: { (snapshot) in
            for comment in snapshot.children {
                let commentToAdd = Comment(snapshot: comment as! FIRDataSnapshot)
                commmentsToAdd.append(commentToAdd)
            }
            
            self.book.comments = commmentsToAdd
            self.commentsTableView.reloadData()
        })
    }
}
