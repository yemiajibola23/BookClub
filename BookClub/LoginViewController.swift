//
//  LoginViewController.swift
//  BookClub
//
//  Created by Yemi Ajibola on 11/3/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FirebaseAuthenticatorDelegate {
    let identifier = "toHome"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseAuthenticator.listenForLogin()
        FirebaseAuthenticator.delegate = self
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        FirebaseAuthenticator.login(email: email, password: password)
    }
    
    @IBAction func createUserButtonTapped(sender: UIButton) {
        
    }
    
    func loginVerified() {
        self.performSegue(withIdentifier: identifier, sender: self)
    }
    
}
