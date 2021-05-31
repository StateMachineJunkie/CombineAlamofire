//
//  PostsVC.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire
import UIKit

class PostsVC: UITableViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = ViewModel<JPPost>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupPullToRefresh()

        // Don't display rows past last valid user value.
        tableView.tableFooterView = UIView()

        // When the view-model changes, reload the table-view.
        viewModel.elements.sink { _ in
            self.tableView.reloadData()
        }
        .store(in: &subscriptions)

        // Initial table-view load.
        tableView.beginRefreshing()
    }
    
    // MARK: - Target Actions
    @IBAction func didPullToRefresh(_ sender: UIRefreshControl) {
        viewModel.fetchElements()
    }

    @objc func didTapLeftBarButton(_ sender: UIBarButtonItem) {
        NSLog("didTapLeftBarButton")
    }

    @objc func didTapRightBarButton(_ sender: UIBarButtonItem) {
        NSLog("didTapRightBarButton")
    }

   // MARK: - UITableViewController Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.elements.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    // MARK: - Private Methods
    private func setupNavBar() {
        navigationItem.title = NSLocalizedString("Posts", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapLeftBarButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapRightBarButton(_:)))
    }

    private func setupPullToRefresh() {
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
    }
}
