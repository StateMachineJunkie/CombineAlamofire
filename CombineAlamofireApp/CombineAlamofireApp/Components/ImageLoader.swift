//
//  ImageLoader.swift
//  CombineAlamofireApp
//
//  Adapted by Michael A. Crawford on 5/29/21.
//

import Combine
import CombineAlamofire
import os.log
import UIKit

/// Based on https://medium.com/flawless-app-stories/reusable-image-cache-in-swift-9b90eb338e8d
/// This class handles the loading and caching of images for `CombineAlamofireApp`.
class ImageLoader: NSObject {
    private let cache = ImageCache()

    /// Load images for display in our UI
    ///
    /// This method utilizes and internal instance of ``ImageCache`` to satisfy image requests from callers.
    /// If the image is in the cache it will be returned immediately. If not, the requested image will be fetched
    /// from the internet. The key used for cache lookup is the given URL. In the case of a miss, said URL is
    /// used to fetch the image from the internet.
    ///
    /// - Parameter url: Used as a key for the internal cache. If there is a cache miss, this parameter is used to fetch the image from the internet.
    /// - Returns: If the image is available in cache or from the URL, it will be returned. If not, `nil` will be returned.
    func loadImage(from url: URL) async -> UIImage? {
        if let image = cache[url] {
            os_log("Cache hit for %{public}s", log: OSLog.imageLoader, type: .debug, url.absoluteString)
            return image
        } else {
            do {
                let image = try await CombineAlamofire.shared.fetchPhoto(url: url)
                self.cache[url] = image
                return image
            } catch {
                return nil
            }
        }
    }
}

extension OSLog {
    static let imageLoader = OSLog(subsystem: OSLog.subsystem, category: "ImageLoader")
}
