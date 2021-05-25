//
//  UsersVM.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire

class UsersVM {

    private var subscriptions = Set<AnyCancellable>()

    // Makes users available to the UI
    var users = CurrentValueSubject<[JPUser], Never>([])

    // Accepts newly created user; adds to current store.
    var addNewUser = PassthroughSubject<JPUser, Never>()

    init() {
        addNewUser
            .sink { [unowned self] newUser in
                self.users.send(self.users.value + [newUser])
            }
            .store(in: &subscriptions)
        fetchUsers()
    }

    /// Acts as a signal to reload the in-memory users cache.
    func fetchUsers() {
        CombineAlamofire.shared.getUsersPublisher()
            .sink { [unowned self] response in
                switch response.result {
                case let .success(users):
                    self.users.send(users)
                case let .failure(error):
                    print("Failed to load users with error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)
    }
}
