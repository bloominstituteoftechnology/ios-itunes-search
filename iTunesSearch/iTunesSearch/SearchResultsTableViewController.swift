//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Ryan Murphy on 5/14/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    let searchResultController = SearchResultController()
    
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // functions and switch:
    var resultType: ResultType {
        get {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                return .apps
            case 1:
                return .music
            case 2:
                return .movie
            default:
                return .apps
            }
        }
    }
    func startSearch () {
        guard let searchTerm = searchBar.text else { return }
        searchResultController.performSearch(with: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startSearch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayCell", for: indexPath)
        
        let searchResult = searchResultController.searchResults[indexPath.row]
        
        
        cell.textLabel?.text = searchResult.title
        
        cell.detailTextLabel?.text = searchResult.creator
        
        // Configure the cell...

        return cell
    }
    
}
