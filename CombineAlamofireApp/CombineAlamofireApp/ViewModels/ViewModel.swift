//
//  ViewModel.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire

class ViewModel<Element: Codable> {

    private var subscriptions = Set<AnyCancellable>()

    // Makes elements available to the UI
    var elements = CurrentValueSubject<[Element], Never>([])

    // Make fetch state available to UI
    var isFetching = CurrentValueSubject<Bool, Never>(false)

    // Accepts newly created element; adds to current store.
    var addNewElement = PassthroughSubject<Element, Never>()

    init() {
        #if false
        addNewComment
            .sink { x in
                print(x)
            } receiveValue: { [unowned self] newElement in
                self.comments.send(self.comments.value + [newComment])
            }.store(in: &subscriptions)
        #else
        addNewElement
            .sink { [unowned self] newElement in
                self.elements.send(self.elements.value + [newElement])
            }
            .store(in: &subscriptions)
        #endif
        fetchElements()
    }

    /// Acts as a signal to reload the in-memory elements cache.
    func fetchElements() {
        isFetching.send(true)
        #if false
        CombineAlamofire.shared.getPublisher()
            .sink { [unowned self] response in
                switch response.result {
                case let .success(elements):
                    self.elements.send(elements)
                case let .failure(error):
                    print("Failed to load albums with error: \(error.localizedDescription)")
                }
                self.isFetching.send(false)
            }
            .store(in: &subscriptions)
        #endif
    }
}
