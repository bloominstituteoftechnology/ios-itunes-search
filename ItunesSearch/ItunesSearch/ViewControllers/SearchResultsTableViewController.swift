//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Marissa Gonzales on 5/4/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    
    let searchResultsController = SearchResultController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

// MARK: - Table view data source

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return searchResultsController.searchResults.count
}
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
        
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
            searchTerm != "" else { return }
        
        var resultType: ResultType!
        
        switch resultTypeSegmentedControl.selectedSegmentIndex {
        case 0: resultType = .software
        case 1: resultType = .musicTrack
        case 2: resultType = .movie
        default: break
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm,  resultType: resultType)
        {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
