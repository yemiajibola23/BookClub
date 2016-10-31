//
//  CommentListDataProvider.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class CommentListDataProvider: NSObject, UITableViewDataSource {
    var book: Book!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        
        //let comment = book.comments[indexPath.row]
        
        
        return cell
    }
    
}
