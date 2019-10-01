//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Jesse Ruiz on 10/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }


}
