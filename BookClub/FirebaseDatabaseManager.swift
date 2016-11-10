//
//  FirebaseDatabaseManager.swift
//  BookClub
//
//  Created by Yemi Ajibola on 11/4/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation
import FirebaseDatabase


class FirebaseDatabaseManager {
    static var userRef: FIRDatabaseReference!
    static var bookRef: FIRDatabaseReference!
    
    init() {
        FirebaseDatabaseManager.userRef = FIRDatabase.database().reference().child("users")
        FirebaseDatabaseManager.bookRef = FIRDatabase.database().reference().child("book")
    }
    
    static func set(userInfo: [String : String], with uid: String) {
        let currentUserRef = userRef.child("users/\(uid)")
       currentUserRef.setValue(userInfo)
    }
    
    static func checkDatabaseFor(book: Book, reader: Reader, withCompletionHandler:@escaping (_ databaseHasBook: Bool) -> Void)  {
        bookRef.observe(.value, with: { snapshot in
            
            var databaseHasBook = false
            for snap in snapshot.children {
                let realSnap = snap as! FIRDataSnapshot
                
                let bookDictionary = realSnap.value as! [String: String]
                
                let bookFromDatabase = Book(key: realSnap.key, value: bookDictionary, reader: reader)
                if book == bookFromDatabase { databaseHasBook = true }
            }
            
            withCompletionHandler(databaseHasBook)
            
        })
    }
    
    static func checkCollectionFor(book: Book, reader: Reader, withCompletionHandler: @escaping (_ databaseHasBook: Bool) -> Void) {
        
        reader.ref!.child("books").observe(.value, with: { snapshot in
            
            var databaseHasBook = false
            for snap in snapshot.children {
                let realSnap = snap as! FIRDataSnapshot
                
                let bookDictionary = realSnap.value as! [String: String]
                
                let bookFromDatabase = Book(key: realSnap.key, value: bookDictionary, reader: reader)
                if book == bookFromDatabase { databaseHasBook = true }
            }
            
            withCompletionHandler(databaseHasBook)
            
        })
    }
}

