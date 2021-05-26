//
//  PostsVC.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/24/21.
//

import Combine
import UIKit

class PostsVC: UITableViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = PostsVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Don't display rows past last valid user value.
        tableView.tableFooterView = UIView()

        // When the view-model changes, reload the table-view.
        viewModel.posts.sink { comments in
            self.tableView.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    // MARK: - UITableViewController Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
