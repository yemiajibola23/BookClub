//
//  Book.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/27/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation

struct Book {
    var title: String
    var author: String
    var comments: [Comment]
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
        self.comments = [Comment]()
    }
}


extension Book : Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        if lhs.author.lowercased() != rhs.author.lowercased() { return false }
        if lhs.title.lowercased() != rhs.title.lowercased() { return false }
        
        return true
    }
}
