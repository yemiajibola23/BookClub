//
//  Comment.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation

struct Comment {
    var text: String
    var username: String
}


extension Comment: Equatable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return (lhs.text == rhs.text) && (lhs.username == rhs.username)
    }
}
