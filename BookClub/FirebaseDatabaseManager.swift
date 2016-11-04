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
        let userRef = FIRDatabase.database().reference().child("users/\(uid)")
       userRef.setValue(userInfo)
    }
}

