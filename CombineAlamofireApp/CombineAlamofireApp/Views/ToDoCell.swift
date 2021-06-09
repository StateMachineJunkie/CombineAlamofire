//
//  ToDoCell.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import CombineAlamofire
import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var completedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toDoIdLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!

    // MARK: - Public Methods
    func configure(with todo: JPToDo) {
        completedImageView.isHighlighted	= todo.completed
        titleLabel.text						= todo.title
		toDoIdLabel.text					= "#\(todo.id.rawValue)"
        userLabel.text						= "#\(todo.userId.rawValue)"
    }
}
