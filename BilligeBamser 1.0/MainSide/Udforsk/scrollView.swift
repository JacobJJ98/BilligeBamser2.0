//
//  scrollView.swift
//  BilligeBamser1.0
//
//  Created by Nicolai Dam on 28/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit

class scrollView: UIScrollView {

    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
       super.viewDidLoad()

       refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
       refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
       tableView.addSubview(refreshControl) // not required when using UITableViewController
    }

    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
    }

}
