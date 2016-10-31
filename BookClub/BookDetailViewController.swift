//
//  BookDetailViewController.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var book: Book!
    
    override func viewDidLoad() {
        self.navigationItem.title = book.title
    }
}
