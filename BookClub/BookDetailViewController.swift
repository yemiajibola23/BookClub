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
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        navigationItem.title = book.title
        authorLabel.text = book.author
    }
}
