//
//  FirebaseAuthenticator.swift
//  BookClub
//
//  Created by Yemi Ajibola on 11/4/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthenticatorDelegate {
    func loginVerified()
}

class FirebaseAuthenticator {
    
    static var delegate: FirebaseAuthenticatorDelegate?
    
    static func login(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: nil)
    }
    
    static func newUser(email: String, password: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: nil)
    }
    
    static func listenForLogin() {
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user != nil {
                // Tell to perform segue
                delegate?.loginVerified()
            }
        })
    }
}
