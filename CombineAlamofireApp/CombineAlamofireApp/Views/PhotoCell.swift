//
//  PhotoCell.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire
import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var photoIdLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    private static var imageLoader = ImageLoader()

    private var subscriptions = Set<AnyCancellable>()

    override func prepareForReuse() {
        subscriptions.forEach { anyCancellable in
            anyCancellable.cancel()
        }
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

        PhotoCell.imageLoader.loadImage(from: photo.thumbnailUrl)
            .sink { [weak self] image in
                guard let image = image else { return }
                self?.thumbnailImageView.image = image
            }
            .store(in: &subscriptions)
    }
}
