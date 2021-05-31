//
//  ImageCache.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/28/21.
//

import UIKit

class ImageCache: NSObject {

    private let cache = NSCache<AnyObject, UIImage>()

    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as AnyObject)
    }

    func removeImage(for url: URL) {
        cache.removeObject(forKey: url as AnyObject)
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as AnyObject)
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
