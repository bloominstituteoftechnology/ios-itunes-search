//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Thomas Cacciatore on 5/21/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text, !searchBarText.isEmpty else { return }
        var resultType: ResultType!
        
        if segmentedControl.selectedSegmentIndex == 0 {
            resultType = .software
        } else if segmentedControl.selectedSegmentIndex == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        
        searchResultsController.performSearch(searchTerm: searchBarText, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)

        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
    

    // Mark: - Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
}
