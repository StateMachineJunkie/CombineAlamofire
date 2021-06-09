//
//  AlbumCell.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import CombineAlamofire
import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var albumIdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!

    // MARK: - Public Methods
    func configure(with album: JPAlbum) {
		albumIdLabel.text	= "#\(album.id.rawValue)"
        titleLabel.text		= album.title
        userLabel.text		= "#\(album.userId.rawValue)"
    }
}
