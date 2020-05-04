//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Vincent Hoang on 5/4/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit
import os.log

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "tableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchResultsTableViewCell else {
            os_log("Dequeued cell is not being displayed by the tableView", log: OSLog.default, type: .error)
            
            let errorCell = SearchResultsTableViewCell()
            
            errorCell.titleLabel.text = "Error retrieving cell"
            errorCell.creatorLabel.text = "Dequeued cell was not being displayed by the tableView"
            
            return errorCell
        }
        
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.searchResult = result
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchQuery = searchBar.text {
            if !searchQuery.isEmpty {
            
                // 0 = software
                // 1 = music
                // 2 = movies
                let searchType = segmentedControl.selectedSegmentIndex
                
                switch searchType {
                case 0:
                    searchResultsController.performSearch(searchTerm: searchQuery, resultType: .software) {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                case 1:
                    searchResultsController.performSearch(searchTerm: searchQuery, resultType: .music) {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                case 2:
                    searchResultsController.performSearch(searchTerm: searchQuery, resultType: .movie) {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                default:
                    os_log("UISegmentedControl index out of bounds", log: OSLog.default, type: .error)
                }
            }
        }
        
        searchBar.resignFirstResponder()
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        searchBarSearchButtonClicked(searchBar)
    }
}
