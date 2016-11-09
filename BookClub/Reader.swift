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
            
        readBooks = [Book]()
        
        ref = user.ref
    }
    
    func add(book: Book) {
        let bookDictionary = book.toAnyObject()
        
        
        checkDatabseForBook(book: book, withCompletionHandler: { checkDB in
            if !checkDB {
                let bookRef = FIRDatabase.database().reference(withPath: "books")
                bookRef.child(book.ID.uuidString).setValue(bookDictionary)
            } else {
                print("Book is already in database. Not adding it.")
            }
            
            
        })
        
        checkCollectionForBook(book: book, withCompletionHandler: { checkCollection in
            if !checkCollection {
                self.ref!.child("books").child(book.ID.uuidString).setValue(bookDictionary)
            } else {
                print("Book is already in database. Not adding it.")
            }
            
        
        })
        
        
    }
    
    func remove(book: Book) {
        book.ref?.removeValue()
    }
    
    
    func checkDatabseForBook(book: Book, withCompletionHandler: @escaping (_ databaseHasBook: Bool) -> Void) {
        
        let bookRef = FIRDatabase.database().reference(withPath: "books")
        
        bookRef.observe(.value, with: { snapshot in
            
            var databaseHasBook = false
            for snap in snapshot.children {
                let realSnap = snap as! FIRDataSnapshot
                
                let bookDictionary = realSnap.value as! [String: String]
                
                let bookFromDatabase = Book(key: realSnap.key, value: bookDictionary, reader: self)
                if book == bookFromDatabase { databaseHasBook = true }
            }
            
            withCompletionHandler(databaseHasBook)
            
        })
    }
    
    func checkCollectionForBook(book: Book, withCompletionHandler: @escaping (_ databaseHasBook: Bool) -> Void) {
        
        
        ref!.child("books").observe(.value, with: { snapshot in
            
            var databaseHasBook = false
            for snap in snapshot.children {
                let realSnap = snap as! FIRDataSnapshot
                
                let bookDictionary = realSnap.value as! [String: String]
                
                let bookFromDatabase = Book(key: realSnap.key, value: bookDictionary, reader: self)
                if book == bookFromDatabase { databaseHasBook = true }
            }
            
            withCompletionHandler(databaseHasBook)
            
        })
    }
    
}
