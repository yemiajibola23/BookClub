//
//  HomeViewController.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var bookListDataProvider: BookListDataProvider!
    @IBOutlet var bookTableView: UITableView!
    
    var reader: Reader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookListDataProvider.reader = reader
        bookTableView.dataSource = bookListDataProvider
        bookTableView.delegate = bookListDataProvider
        
        reader = Reader(name: "Test Reader")
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
            
            self.reader.addBook(book: bookToAdd)
            self.bookTableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addBookAlert.addAction(okAction)
        addBookAlert.addAction(cancelAction)
        
        present(addBookAlert, animated: true, completion: nil)
    }

}
