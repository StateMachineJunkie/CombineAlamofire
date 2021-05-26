//
//  ToDosVC.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import UIKit

class ToDosVC: UITableViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = ToDosVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Don't display rows past last valid user value.
        tableView.tableFooterView = UIView()

        // When the view-model changes, reload the table-view.
        viewModel.todos.sink { comments in
            self.tableView.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    // MARK: - UITableViewController Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todos.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        cell.configure(with: viewModel.todos.value[indexPath.row])
        return cell
    }
}
