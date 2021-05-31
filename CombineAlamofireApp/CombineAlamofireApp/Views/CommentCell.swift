//
//  CommentCell.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import CombineAlamofire
import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postIdLabel: UILabel!

    // MARK: - Public Methods
    func configure(with comment: JPComment) {
        bodyLabel.text      = comment.body
        emailLabel.text     = comment.email.rawValue
        nameLabel.text      = comment.name
        postIdLabel.text    = "#\(comment.postId.rawValue)"
    }
}
