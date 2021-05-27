//
//  ToDosVC.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire
import UIKit

class ToDosVC: UITableViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = ViewModel<JPToDo>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup pull-to-refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        viewModel.isFetching
            .removeDuplicates()
            .sink { [unowned self] isFetching in
                if isFetching {
                    self.tableView.refreshControl?.beginRefreshing()
                } else {
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
            .store(in: &subscriptions)

        // Don't display rows past last valid user value.
        tableView.tableFooterView = UIView()

        // When the view-model changes, reload the table-view.
        viewModel.elements.sink { _ in
            self.tableView.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    // MARK: - Target Actions
    @IBAction func didPullToRefresh(_ sender: UIRefreshControl) {
        viewModel.fetchElements()
    }

   // MARK: - UITableViewController Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.elements.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        cell.configure(with: viewModel.elements.value[indexPath.row])
        return cell
    }
}
