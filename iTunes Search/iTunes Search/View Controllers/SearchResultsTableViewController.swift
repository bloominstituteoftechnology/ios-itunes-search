//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Moses Robinson on 1/22/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }
    
    let reuseIdentifier = "ResultCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }

    //MARK: - Properties
    
    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
}
