//
//  BookDetailViewController.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BookDetailViewController: UIViewController, UITextFieldDelegate {
    var book: Book!
    var reader: Reader!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var commentListDataProvider: CommentListDataProvider!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        navigationItem.title = book.title
        authorLabel.text = book.author
        commentListDataProvider.book = book
        
        commentsTableView.dataSource = commentListDataProvider
        commentsTableView.delegate = commentListDataProvider
        
        fetchComments()
        
        postButton.isEnabled = false
        
        commentTextField.addTarget(self, action: #selector(BookDetailViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    func fetchComments() {
        var commmentsToAdd:[Comment] = []
        
        book.ref!.child("comments").observe(.value, with: { (snapshot) in
            for comment in snapshot.children {
                let commentToAdd = Comment(snapshot: comment as! FIRDataSnapshot)
                commmentsToAdd.append(commentToAdd)
            }
            
            self.book.comments = commmentsToAdd
            
            self.commentListDataProvider.book = self.book
            self.commentsTableView.reloadData()
        })
    }
    
    func textFieldDidChange() {
        if !commentTextField.text!.isEmpty {
            postButton.isEnabled = true
        } else {
            postButton.isEnabled = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // TODO: Raise keyboard
    }
    
    @IBAction func addNewComment(sender: UIButton) {
        let comment = Comment(text: commentTextField.text!, username: reader.name)
        book.add(comment: comment)
        
        fetchComments()
    }
}
