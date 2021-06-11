//
//  PhotoCell.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire
import UIKit

@MainActor
class PhotoCell: UITableViewCell {

    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var photoIdLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    private static var imageLoader = ImageLoader()

    private var task: Task.Handle<(), Never>?

    override func prepareForReuse() {
        task?.cancel()
        albumLabel.text = ""
        titleLabel.text = ""
        photoIdLabel.text = ""
    }

    // MARK: - Public Methods
    func configure(with photo: JPPhoto) {
        albumLabel.text						= "#\(photo.albumId.rawValue)"
        titleLabel.text						= photo.title
		photoIdLabel.text					= "#\(photo.id.rawValue)"
        thumbnailImageView.image            = UIImage(systemName: "photo")

        task = async {
            if let image = await PhotoCell.imageLoader.loadImage(from: photo.thumbnailUrl) {
                thumbnailImageView.image = image
            }
        }
    }
}
