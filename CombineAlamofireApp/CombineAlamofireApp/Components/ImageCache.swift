//
//  ImageCache.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/28/21.
//

import os.log
import UIKit

class ImageCache: NSObject {

    private let cache = NSCache<NSString, UIImage>()

    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }

    func removeImage(for url: URL) {
        cache.removeObject(forKey: url.absoluteString as NSString)
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}

extension ImageCache {
    subscript(_ url: URL) -> UIImage? {
        get {
            return image(for: url)
        }
        set {
            guard let image = newValue else {
                removeImage(for: url)
                return
            }
            return setImage(image, for: url)
        }
    }
}
