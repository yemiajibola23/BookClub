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
        
        FirebaseAuthenticator.delegate = self
        FirebaseAuthenticator.listenForLogin()
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
    
        FirebaseAuthenticator.login(email: email, password: password)
    }
    
    @IBAction func createUserButtonTapped(sender: UIButton) {
        let createUserAlert = UIAlertController(title: "Create A New Account", message: nil, preferredStyle: .alert)
        createUserAlert.addTextField { (textField) in
            textField.placeholder = "Email Address"
        }
        createUserAlert.addTextField { (textField) in
            textField.placeholder = "Password"
        }
        createUserAlert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(_) in
            let email = createUserAlert.textFields?[0].text!
            let password = createUserAlert.textFields?[1].text!
            let name = createUserAlert.textFields?[2].text!
            FirebaseAuthenticator.newUser(email: email!, password: password!, name: name!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        createUserAlert.addAction(okAction)
        createUserAlert.addAction(cancelAction)
        
        present(createUserAlert, animated: true, completion: nil)
    }
    
    func loginVerified() {
        self.performSegue(withIdentifier: identifier, sender: self)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func errorAlert(message: String) {
        let errorAlert = UIAlertController(title: "An error occurred processing your request. Please try again", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
