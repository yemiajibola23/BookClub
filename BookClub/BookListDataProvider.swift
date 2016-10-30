//
//  BookListDataProvider.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/29/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class BookListDataProvider: NSObject, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    var reader: Reader!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reader.readBooksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        if let book = reader.bookAt(index: indexPath.row) {
                
        }
        
        return cell
        
    }
    
    
}
