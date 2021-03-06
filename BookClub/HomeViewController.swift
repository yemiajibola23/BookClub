//
//  HomeViewController.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    @IBOutlet var bookListDataProvider: BookListDataProvider!
    @IBOutlet var bookTableView: UITableView!
    
    var reader: Reader!
    let identifier = "toBookDetail"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookListDataProvider.delegate = self
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
                        
            guard let user = user else { return }
            FIRDatabase.database().reference(withPath: "users/\(user.uid)").observe(.value, with: { (snapshot) in
                self.reader = Reader(user: snapshot)
                
                self.bookListDataProvider.reader = self.reader
                self.bookTableView.dataSource = self.bookListDataProvider
                self.bookTableView.delegate = self.bookListDataProvider
                
                self.navigationItem.title = "Hi \(self.reader.name)!"
                
                self.fetchBooksForReader()
            })
        })

    }

    @IBAction func addNewBook(sender: UIBarButtonItem) {
        let addBookAlert = UIAlertController(title: "Add A Book", message: nil, preferredStyle: .alert)
        
        addBookAlert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        
        addBookAlert.addTextField { (textField) in
            textField.placeholder = "Author"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(_) in
            let title = addBookAlert.textFields?.first?.text
            let author = addBookAlert.textFields?.last?.text
            let bookToAdd =  Book(title: title!, author: author!)
            
            self.reader.add(book: bookToAdd)
            self.fetchBooksForReader()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addBookAlert.addAction(okAction)
        addBookAlert.addAction(cancelAction)
        
        present(addBookAlert, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonTapped(sender: UIBarButtonItem) {
        do {
            try FIRAuth.auth()?.signOut()
            _ = navigationController?.popViewController(animated: true)
        } catch {
            errorAlert(message: error.localizedDescription)
        }
    }
    
    func fetchBooksForReader() {
        var booksToAdd:[Book] = []
        
        reader.ref!.child("books").observe(.value, with: { snapshot in
            
            for book in snapshot.children {
                let bookToAdd = Book(snapshot: book as! FIRDataSnapshot)
                booksToAdd.append(bookToAdd)
            }
            
            self.reader.readBooks = booksToAdd
            self.bookTableView.reloadData()
        })
    }
    
    func errorAlert(message: String) {
        let errorAlert = UIAlertController(title: "An error occurred processing your request. Please try again", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            let bookDetailVC = segue.destination as! BookDetailViewController
            bookDetailVC.book = reader.readBooks[bookTableView.indexPathForSelectedRow!.row]
            bookDetailVC.reader = reader
        }
    }
}

extension HomeViewController: BookListProviderDelegate {
    func bookListWasUpdated() {
        self.fetchBooksForReader()
    }
}
