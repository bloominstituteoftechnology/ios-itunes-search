//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by brian vilchez on 9/4/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // searchBar.delegate = self
    }
    
    var searchResultsCOntroller = SearchResultController()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsCOntroller.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItunesItemCell", for: indexPath)
        let itunesSearchedItem = searchResultsCOntroller.searchResults[indexPath.row]
        cell.textLabel?.text = itunesSearchedItem.title
        cell.detailTextLabel?.text = itunesSearchedItem.creator
        return cell
    }

}
extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        searchResultsCOntroller.performSearch(with: searchTerm, resultType: .movie) {
            
        }
    }
}
