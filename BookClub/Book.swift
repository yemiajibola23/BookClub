//
//  Book.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/27/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Book {
    var title: String
    var author: String
    var comments: [Comment]
    var ID: String?
    var ref: FIRDatabaseReference?
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
        comments = [Comment]()
    }
    
    init(snapshot: FIRDataSnapshot) {
        ID = snapshot.key
        let value = snapshot.value as! [String: AnyObject]
        
        title = value["title"]! as! String
        author = value["author"]! as! String
        
        if let commentsFromDatabase = value["comments"] {
            //comments = commentsFromDatabase
        }
        else { comments = [Comment]() }
        
        ref = snapshot.ref
    }
    
    init(key: String, value: [String : String], reader: Reader) {
        ID = key
        
        title = value["title"]!
        author = value["author"]!
        
        ref = FIRDatabase.database().reference(withPath: "users/\(reader.ID)/books/\(key)")
        
        comments = [Comment]()
    }
    
    func toAnyObject() -> [String: String] {
        return ["title": self.title, "author": self.author]
    }
    
    func add(comment: Comment) {
        let commentDictionary = comment.toAnyObject()
        ref!.child("comments").childByAutoId().setValue(commentDictionary)
    }
   
}


extension Book : Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        if lhs.author.lowercased() != rhs.author.lowercased() { return false }
        if lhs.title.lowercased() != rhs.title.lowercased() { return false }
        
        return true
    }
}
