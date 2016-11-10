//
//  Reader.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/28/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation
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
        
        readBooks = [Book]()
        
        ref = user.ref
    }
    
    func add(book: Book) {
        let bookDictionary = book.toAnyObject()
        
        FirebaseDatabaseManager.checkDatabaseFor(book: book, reader: self, withCompletionHandler: { checkDB in
            if !checkDB {
                let bookRef = FIRDatabase.database().reference(withPath: "books")
                bookRef.child(book.ID.uuidString).setValue(bookDictionary)
            } else {
                print("Book is already in database. Not adding it.")
            }
        })
        
        FirebaseDatabaseManager.checkCollectionFor(book: book, reader: self, withCompletionHandler: { checkCollection in
            if !checkCollection {
                self.ref!.child("books").child(book.ID.uuidString).setValue(bookDictionary)
            } else {
                print("Book is already in collection. Not adding it.")
            }
        })
    }
    
    func remove(book: Book) {
        book.ref!.removeValue()
    }
    
    
}
