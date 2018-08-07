//
//  SearchResultsTableViewController.swift
//  ios-itunes-search
//
//  Created by Conner on 8/7/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    
    // MARK: - Properties
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        return cell
    }
}
