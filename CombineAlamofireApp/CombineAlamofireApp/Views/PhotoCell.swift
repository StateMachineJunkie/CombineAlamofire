//
//  PhotoCell.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import CombineAlamofire
import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var photoIdLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Public Methods
    func configure(with photo: JPPhoto) {
        albumLabel.text						= "#\(photo.albumId.rawValue)"
        titleLabel.text						= photo.title
		photoIdLabel.text					= "#\(photo.id.rawValue)"
        //thumbnailImageView.isHighlighted	= photo.completed
    }
}
