//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Jocelyn Stuart on 1/22/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        var resultType: ResultType!
        
        if self.segmentControl.selectedSegmentIndex == 0 {
            resultType = .software
        } else if self.segmentControl.selectedSegmentIndex == 1 {
            resultType = .movie
        } else {
            resultType = .musicTrack
        }
        
        searchResultController.performSearch(with: searchTerm, andResult: resultType) { (searchResults, error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        cell.textLabel?.text = searchResultController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultController.searchResults[indexPath.row].creator
        
        return cell
    }
    
    
    let searchResultController = SearchResultController()
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    

}
