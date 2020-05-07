//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Josh Kocsis on 5/7/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    @IBOutlet weak var selectionTypeControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as! SearchResultTableViewCell
        
        let result = searchResultsController.searchResults[indexPath.row]
        cell.searchResult?.title = result.title
        cell.searchResult?.creator = result.creator
        
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        var resultType: ResultType!
        
        switch selectionTypeControl.selectedSegmentIndex  {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        self.searchResultsController.performSearch(searchTerm:searchTerm, resultType: resultType)
            DispatchQueue.main.async {
                self.tableView.reloadData()
        }
    }
}

