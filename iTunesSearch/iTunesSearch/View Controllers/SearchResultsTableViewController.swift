//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Harmony Radley on 4/7/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!

    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self 
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.detailTextLabel?.text = searchResult.creator
        cell.textLabel?.text = searchResult.title
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    

func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text else { return }
    
    var resultType: ResultType!
    
    switch segmentedControl.selectedSegmentIndex {
    case 0:
        resultType = .software
    case 1:
        resultType = .musicTrack
    case 2:
        resultType = .movie
    default:
        resultType = .software
    }
    
    searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {_ in
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
    
    
    
}
