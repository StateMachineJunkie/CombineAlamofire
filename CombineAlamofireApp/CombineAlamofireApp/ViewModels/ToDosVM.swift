//
//  ToDosVM.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire

class ToDosVM {

    private var subscriptions = Set<AnyCancellable>()

    // Makes to-dos available to the UI
    var todos = CurrentValueSubject<[JPToDo], Never>([])

    // Accepts newly created to-do; adds to current store.
    var addNewToDo = PassthroughSubject<JPToDo, Never>()

    init() {
        addNewToDo
            .sink { [unowned self] newToDo in
                self.todos.send(self.todos.value + [newToDo])
            }
            .store(in: &subscriptions)
        fetchToDos()
    }

    /// Acts as a signal to reload the in-memory to-dos cache.
    func fetchToDos() {
        CombineAlamofire.shared.getToDosPublisher()
            .sink { [unowned self] response in
                switch response.result {
                case let .success(todos):
                    self.todos.send(todos)
                case let .failure(error):
                    print("Failed to load todos with error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)
    }
}
