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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookListDataProvider.reader = Reader(name: nil)
        bookTableView.dataSource = bookListDataProvider
        bookTableView.delegate = bookListDataProvider
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

}
