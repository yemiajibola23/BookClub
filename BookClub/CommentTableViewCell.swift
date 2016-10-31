//
//  CommentTableViewCell.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/31/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    var comment: Comment!

    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var commentUserLabel: UILabel!
    
    func configCellWithComment(comment: Comment) {
        commentTextLabel.text = comment.text
        commentUserLabel.text = comment.username
    }
    

}
