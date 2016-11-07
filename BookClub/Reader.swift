//
//  Reader.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/28/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Reader {
    var readBooks: [Book]
    var name: String
    var ID: String?
    var ref: FIRDatabaseReference?
    
    
    init(name: String?) {
        
        if let name = name { self.name = name }
        else { self.name = "" }
        
        readBooks = [Book]()
    }
    
    init(user: FIRDataSnapshot) {
        
        ID = user.key 
        
        let value = user.value as! [String: AnyObject]
        
        name = value["name"] as! String
        
        let bookDictionary = value["books"] as! [String : AnyObject]
    
        readBooks = [Book]()
        
        var finalBooks:[Book] = []
        for item in bookDictionary {
            let book = Book(key: item.key, value: item.value as! [String : String], reader: self)
            finalBooks.append(book)
        }
        
        readBooks = finalBooks
        
        ref = user.ref
    }
    
    func add(book: Book) {
        let bookDictionary = book.toAnyObject()
        ref!.child("books").childByAutoId().setValue(bookDictionary)
    }
    
    func remove(book: Book) {
        book.ref?.removeValue()
    }
    
}
