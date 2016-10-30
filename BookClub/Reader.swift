//
//  Reader.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/28/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation

class Reader {
    private var readBooks: [Book]
    var name: String
    
    var readBooksCount: Int { return readBooks.count }
    
    init(name: String?) {
        
        if let name = name { self.name = name }
        else { self.name = "" }
        
        readBooks = [Book]()
    }
    
    func addBook(book: Book) {
        readBooks.append(book)
    }
    
    func bookAt(index: Int) -> Book? {
        return readBooks[index]
    }
    
    func removeBookAt(index: Int) -> Book {
        return readBooks.remove(at: index)
    }
    
}
