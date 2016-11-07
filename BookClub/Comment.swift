//
//  Comment.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Comment {
    var text: String
    var username: String
    var ref: FIRDatabaseReference?
    var ID: String?
    
    init(text: String, username: String) {
        self.text = text
        self.username = username
    }
    
    init(snapshot: FIRDataSnapshot) {
        ID = snapshot.key
        
        let value = snapshot.value as! [String: String]
        
        text = value["text"]!
        username = value["username"]!
        
        ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: String] {
        return ["text": self.text, "username": self.username]
    }
}


extension Comment: Equatable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return (lhs.text == rhs.text) && (lhs.username == rhs.username)
    }
}
