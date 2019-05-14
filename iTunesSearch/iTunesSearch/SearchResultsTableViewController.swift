//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Thomas Cacciatore on 5/14/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        if segmentedControl.selectedSegmentIndex == 0 {
            resultType = .software
        } else if segmentedControl.selectedSegmentIndex == 1 {
            resultType = .musicTrack
        } else if segmentedControl.selectedSegmentIndex == 2 {
            resultType = .movie
        }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) {_ in 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as? SearchResultsTableViewCell else { return UITableViewCell() }
        
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.result = result
        
        return cell
    }

    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
}
