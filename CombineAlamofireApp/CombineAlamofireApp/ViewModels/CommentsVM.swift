//
//  CommentsVM.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire

class CommentsVM {

    private var subscriptions = Set<AnyCancellable>()

    // Makes comments available to the UI
    var comments = CurrentValueSubject<[JPComment], Never>([])

    // Accepts newly created comment; adds to current store.
    var addNewComment = PassthroughSubject<JPComment, Never>()

    init() {
        #if false
        addNewComment
            .sink { x in
                print(x)
            } receiveValue: { [unowned self] newComment in
                self.comments.send(self.comments.value + [newComment])
            }.store(in: &subscriptions)
        #else
        addNewComment
            .sink { [unowned self] newComment in
                self.comments.send(self.comments.value + [newComment])
            }
            .store(in: &subscriptions)
        #endif
        fetchComments()
    }

    /// Acts as a signal to reload the in-memory comments cache.
    func fetchComments() {
        CombineAlamofire.shared.getCommentsPublisher()
            .sink { [unowned self] response in
                switch response.result {
                case let .success(comments):
                    self.comments.send(comments)
                case let .failure(error):
                    print("Failed to load comments with error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)
    }
}
