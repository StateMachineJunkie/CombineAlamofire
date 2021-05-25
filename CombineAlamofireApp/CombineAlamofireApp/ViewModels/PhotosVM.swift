//
//  PhotosVM.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire

class PhotosVM {

    private var subscriptions = Set<AnyCancellable>()

    // Makes photos available to the UI
    var photos = CurrentValueSubject<[JPPhoto], Never>([])

    // Accepts newly created photo; adds to current store.
    var addNewPhoto = PassthroughSubject<JPPhoto, Never>()

    init() {
        addNewPhoto
            .sink { [unowned self] newPhoto in
                self.photos.send(self.photos.value + [newPhoto])
            }
            .store(in: &subscriptions)
        fetchPhotos()
    }

    /// Acts as a signal to reload the in-memory photos cache.
    func fetchPhotos() {
        CombineAlamofire.shared.getPhotosPublisher()
            .sink { [unowned self] response in
                switch response.result {
                case let .success(photos):
                    self.photos.send(photos)
                case let .failure(error):
                    print("Failed to load photos with error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)
    }
}
