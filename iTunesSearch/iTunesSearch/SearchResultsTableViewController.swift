//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Paul Yi on 1/29/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

extension SearchResultsTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles! [selectedScope])
    }
}

class SearchResultsTableViewController: UITableViewController {
    let searchResultsController = SearchResultController()
    let searchResults = [SearchResult]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredSearchResults = [SearchResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredSearchResults = searchResults.filter({( searchResult : SearchResult) -> Bool in
            let doesCategoryMatch = (scope == "All") || (searchResult.creator == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch &&
        searchResult.title.lowercased().contains(searchText.lowercased())
            }
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex !=
    0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredSearchResults.count
        }
        
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let searchResult: SearchResult
        if isFiltering() {
            searchResult = filteredSearchResults[indexPath.row]
        } else {
            searchResult = searchResults[indexPath.row]
        }
        cell.textLabel!.text = searchResult.title
        cell.detailTextLabel!.text = searchResult.creator
        return cell
    }
    
}
