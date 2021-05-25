//
//  PostsVM.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire

class PostsVM {

    private var subscriptions = Set<AnyCancellable>()

    // Makes posts available to the UI
    var posts = CurrentValueSubject<[JPPost], Never>([])

    // Accepts newly created post; adds to current store.
    var addNewPost = PassthroughSubject<JPPost, Never>()

    init() {
        addNewPost
            .sink { [unowned self] newPost in
                self.posts.send(self.posts.value + [newPost])
            }
            .store(in: &subscriptions)
        fetchPosts()
    }

    /// Acts as a signal to reload the in-memory posts cache.
    func fetchPosts() {
        CombineAlamofire.shared.getPostsPublisher()
            .sink { [unowned self] response in
                switch response.result {
                case let .success(posts):
                    self.posts.send(posts)
                case let .failure(error):
                    print("Failed to load posts with error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)
    }
}
