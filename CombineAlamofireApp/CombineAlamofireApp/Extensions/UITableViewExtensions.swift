//
//  UITableViewExtensions.swift
//  CombineAlamofireApp
//
//  Created by Michael A. Crawford on 5/31/21.
//

import UIKit

// Based on https://gist.github.com/mttcrsp/53a6fec3a5a16e020aa97926428057c9
extension UITableView {
    /// Programmatically begin refreshing.
    func beginRefreshing() {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else { return }
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
        let contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
        setContentOffset(contentOffset, animated: true)
    }

    /// Programmatically end refreshing.
    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
}
