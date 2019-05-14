//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Mitchell Budge on 5/14/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    let searchResultsController = SearchResultController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    } // end of view did load

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.results.count
    } // end of number of rows

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = searchResultsController.
        // Configure the cell...

        return cell
    }
}
