//
//  ElementList.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael A. Crawford on 6/14/21.
//

import Alamofire
import Combine
import CombineAlamofire

class ElementList<Element: Decodable>: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()

    @Published private(set) var elements: [Element]

    init() {
        elements = []
    }

    func addNewElement(element: Element) {
        elements.append(element)
    }

    func fetchElements() {
        let publisher: DataResponsePublisher<[Element]> = CombineAlamofire.shared.getPublisher()
        publisher
            .sink { [unowned self] response in
                switch response.result {
                case let .success(elements):
                    self.elements = elements
                case let .failure(error):
                    print("Failed to load elements with error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)
    }

    func removeElement(at index: Int) {
        elements.remove(at: index)
    }
}
