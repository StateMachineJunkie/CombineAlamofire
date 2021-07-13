//
//  ImageLoader.swift
//  CombineAlamofireApp
//
//  Adapted by Michael A. Crawford on 5/29/21.
//

import Combine
import UIKit

/// Based on https://medium.com/flawless-app-stories/reusable-image-cache-in-swift-9b90eb338e8d
class ImageLoader: NSObject {
    private let cache = ImageCache()

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        } else {
            return URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map { (data, /* response */_) -> UIImage? in return UIImage(data: data) }
                .catch { error in return Just(nil) }
                .handleEvents(receiveOutput: { [unowned self] image in
                    guard let image = image else { return }
                    self.cache[url] = image
                })
                .eraseToAnyPublisher()
        }
    }
}
