//
//  UserCell.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import CombineAlamofire
import UIKit

class UserCell: UITableViewCell {

	@IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!

    // MARK: - Public Methods
    func configure(with user: JPUser) {
        companyNameLabel.text	= user.company?.name
        emailLabel.text		    = user.email.rawValue
        userIdLabel.text    	= "#\(user.id.rawValue)"
        usernameLabel.text      = user.username
		websiteLabel.text		= user.website?.absoluteString
    }
}
