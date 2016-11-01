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
    private var comments: [Comment]
    var commentsCount: Int { return comments.count }
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
        comments = [Comment]()
    }
    
    mutating func addComment(comment: Comment) {
        comments.append(comment)
    }
    
    func commentAt(index: Int) -> Comment? {
        
        if index >= commentsCount || index < 0 { return nil }
        return comments[index]
    }
}


extension Book : Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        if lhs.author.lowercased() != rhs.author.lowercased() { return false }
        if lhs.title.lowercased() != rhs.title.lowercased() { return false }
        
        return true
    }
}
