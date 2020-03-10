//
//  SearchResultsTableViewController.swift
//  iTunesStoreSearch
//
//  Created by Bradley Diroff on 3/10/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet var segmentView: UISegmentedControl!
    @IBOutlet var searchBarView: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBarView.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let search = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = search.title
        cell.detailTextLabel?.text = search.creator

        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        
        if searchText != "" {
            
            searchResultsController.searchResults = []
            
            var resultType: ResultType!
            
            switch segmentView.selectedSegmentIndex {
            case 0:
                resultType = .software
            case 1:
                resultType = .musicTrack
            case 2:
                resultType = .movie
            default:
                resultType = .software
            }
            
            searchResultsController.performSearch(searchTerm: searchText, resultType: resultType) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }
    
}
