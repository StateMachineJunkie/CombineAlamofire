//
//  ViewModel.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Alamofire
import Combine
import CombineAlamofire


protocol FetchingViewModel {
    var isFetching: CurrentValueSubject<Bool, Never> { get }
    func fetchElements() -> Void
}

class ViewModel<Element: Codable>: FetchingViewModel {

    private var subscriptions = Set<AnyCancellable>()

    // Makes elements available to the UI
    var elements = CurrentValueSubject<[Element], Never>([])

    // Make fetch state available to UI
    var isFetching = CurrentValueSubject<Bool, Never>(false)

    // Accepts newly created element; adds to current store.
    var addNewElement = PassthroughSubject<Element, Never>()

    init() {
        addNewElement
            .sink { [unowned self] newElement in
                self.elements.send(self.elements.value + [newElement])
            }
            .store(in: &subscriptions)
        fetchElements()
    }

    /// Acts as a signal to reload the in-memory elements cache.
    func fetchElements() {
        guard isFetching.value == false else { return }
        isFetching.send(true)
        let publisher: DataResponsePublisher<[Element]> = CombineAlamofire.shared.getPublisher()
        publisher
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
    }
}
