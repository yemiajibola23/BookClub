//
//  BookListDataProvider.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

protocol BookListProviderDelegate {
    func bookListWasUpdated()
}

class BookListDataProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    var reader: Reader!
    var delegate: BookListProviderDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reader.readBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        let bookForCell = reader.readBooks[indexPath.row]
        cell.configCellWithBook(book: bookForCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bookToDelete = reader.readBooks[indexPath.row]
            reader.remove(book: bookToDelete)
            delegate?.bookListWasUpdated()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    
}
