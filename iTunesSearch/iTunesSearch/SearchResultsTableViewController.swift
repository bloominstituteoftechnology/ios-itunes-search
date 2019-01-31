//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Paul Yi on 1/29/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    // MARK: - Properties
    
    let searchResultsController = SearchResultController()
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    // MARK: - Setup Search Controller
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["Apps", "Music", "Movies"]
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search iTunes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        return cell
    }
    
    // MARK: - Private perform search helper function
    
    private func performSearch(searchBar: UISearchBar) {
        
        // Check scopeIndex and assign related value to the resultType
        var resultType: ResultType!
        switch searchBar.selectedScopeButtonIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        // Get searchTerm from searchBar's text
        guard let term = searchBar.text, !term.isEmpty,
            let result = resultType else { return }
        
        // Perform search operation
        searchResultsController.performSearch(searchTerm: term, resultType: result) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
            }
            // Reload table view in main queue because URLSession runs in backgroung queue
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        performSearch(searchBar: searchBar)
    }
    
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        performSearch(searchBar: searchBar)
    }
    
}
