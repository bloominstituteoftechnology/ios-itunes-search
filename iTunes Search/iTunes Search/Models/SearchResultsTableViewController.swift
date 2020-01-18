//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Sal Amer on 1/17/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
//

import UIKit

let searchResultsController = SearchResultController()
var resultType: ResultType!

class SearchResultsTableViewController: UITableViewController {

    //IB Outlets
    @IBOutlet weak var segmentedControlBar: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
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
        return searchResultsController.searchResults.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! SearchResultTableViewCell

        // Configure the cell...
        guard indexPath.row < searchResultsController.searchResults.count else { return cell}
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.searchResult = searchResult
        return cell
    }
  
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text else { return }
        
        switch segmentedControlBar.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        print("Searching for \(searchTerm)..")
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    
    }
   
}
