//
//  AlbumsVM.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire

class AlbumsVM {

    private var subscriptions = Set<AnyCancellable>()

    // Makes albums available to the UI
    var albums = CurrentValueSubject<[JPAlbum], Never>([])

    // Accepts newly created album; adds to current store.
    var addNewAlbum = PassthroughSubject<JPAlbum, Never>()

    init() {
        addNewAlbum
            .sink { [unowned self] newAlbum in
                self.albums.send(self.albums.value + [newAlbum])
            }
            .store(in: &subscriptions)
        fetchAlbums()
    }

    /// Acts as a signal to reload the in-memory albums cache.
    func fetchAlbums() {
        CombineAlamofire.shared.getAlbumsPublisher()
            .sink { [unowned self] response in
                switch response.result {
                case let .success(albums):
                    self.albums.send(albums)
                case let .failure(error):
                    print("Failed to load albums with error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)
    }
}
