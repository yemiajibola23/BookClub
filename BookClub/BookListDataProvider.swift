//
//  BookListDataProvider.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class BookListDataProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
    var reader: Reader!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reader.readBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        let bookForCell = reader.readBooks[indexPath.row]
        cell.configCellWithBook(book: bookForCell)

        
        return cell
        
    }
    
    
}
