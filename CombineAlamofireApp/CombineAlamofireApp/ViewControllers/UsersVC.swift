//
//  UsersVC.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import UIKit

class UsersVC: UITableViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = UsersVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Don't display rows past last valid user value.
        tableView.tableFooterView = UIView()

        // When the view-model changes, reload the table-view.
        viewModel.users.sink { users in
            self.tableView.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    // MARK: - UITableViewController Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.configure(with: viewModel.users.value[indexPath.row])
        return cell
    }
}
