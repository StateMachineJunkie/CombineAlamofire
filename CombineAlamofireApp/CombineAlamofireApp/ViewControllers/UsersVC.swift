//
//  UsersVC.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import CombineAlamofire
import Eureka
import UIKit

class UsersVC: UITableViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = ViewModel<JPUser>()

    // MARK: - UIViewController Overrides
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
        setEditing(!isEditing, animated: true)
    }

    @objc func didTapRightBarButton(_ sender: UIBarButtonItem) {
        // Present add-user form.
        let controller = AddUserForm(with: viewModel)
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true)
    }

    // MARK: - UITableViewDataSource Overrides
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.configure(with: viewModel.elements.value[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeElementAtIndex.send(indexPath.row)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.elements.value.count
    }

    // MARK: - UITableViewDelegate Overrides
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // MARK: - Private Methods
    private func setupNavBar() {
        navigationItem.title = NSLocalizedString("Users", comment: "")
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
