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
    
    static func set(userInfo: [String : String], with uid: String) {
        let userRef = FIRDatabase.database().reference().child("users")
        let currentUserRef = userRef.child("\(uid)")
       currentUserRef.setValue(userInfo)
    }
    
    static func checkDatabaseFor(book: Book, withCompletionHandler:@escaping (_ databaseHasBook: Bool) -> Void)  {
        
        let bookRef =  FIRDatabase.database().reference().child("books")
        bookRef.observe(.value, with: { snapshot in
            
            var databaseHasBook = false
            for snap in snapshot.children {
                let realSnap = snap as! FIRDataSnapshot
                
                let bookDictionary = realSnap.value as! [String: String]
                
                let bookFromDatabase = Book(key: realSnap.key, value: bookDictionary, reader: nil)
                if book == bookFromDatabase { databaseHasBook = true }
            }
            
            withCompletionHandler(databaseHasBook)
            
        })
    }
    
    static func checkCollectionFor(book: Book, reader: Reader, withCompletionHandler: @escaping (_ databaseHasBook: Bool) -> Void) {
        
        
        reader.ref!.child("books").observe(.value, with: { snapshot in
            
            var readerHasBookInCollection = false
            for snap in snapshot.children {
                let realSnap = snap as! FIRDataSnapshot
                
                let bookDictionary = realSnap.value as! [String: String]
                
                let bookFromDatabase = Book(key: realSnap.key, value: bookDictionary, reader: reader)
                if book == bookFromDatabase { readerHasBookInCollection = true }
            }
            
            withCompletionHandler(readerHasBookInCollection)
            
        })
    }
}

