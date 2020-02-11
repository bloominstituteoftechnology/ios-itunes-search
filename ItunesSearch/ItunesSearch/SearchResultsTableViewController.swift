//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Elizabeth Wingate on 2/11/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    
    var searchResultController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)

       let searchResult = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
}

extension searchBarSearchButtonClicked: UISearchBarDelegate {
    
}
