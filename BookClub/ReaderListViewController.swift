//
//  ReaderListViewController.swift
//  BookClub
//
//  Created by Yemi Ajibola on 11/10/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ReaderListViewController: UIViewController {
    @IBOutlet weak var readerListTableView: UITableView!
    @IBOutlet weak var readerListDataProvider: ReaderListDataProvider!
    
    
    override func viewDidLoad() {
        readerListTableView.dataSource = readerListDataProvider
    }
    
    
    
}
