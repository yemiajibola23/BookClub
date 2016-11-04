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
    
    static func newUser(email: String, password: String, name: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                let userInfo = ["email": email, "password": password, "name": name]
                FirebaseDatabaseManager.set(userInfo: userInfo, with: user!.uid)
                
                self.login(email: email, password: password)
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    
    static func listenForLogin() {
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user != nil {
                delegate?.loginVerified()
            }
        })
    }
}
