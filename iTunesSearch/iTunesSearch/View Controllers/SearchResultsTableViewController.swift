//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Shawn James on 4/6/20.
//  Copyright © 2020 Shawn James. All rights reserved.
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
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
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
        case 3:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            print(self.searchResultsController.searchResults)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
