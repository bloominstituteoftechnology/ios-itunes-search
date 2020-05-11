//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Aaron Peterson on 5/10/20.
//  Copyright © 2020 Aaron Peterson. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var segmentedController: UISegmentedControl!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        // Configure the cell...
        let resultOfSearch = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = resultOfSearch.title
        cell.detailTextLabel?.text = resultOfSearch.creator
        
        return cell
    }


}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        searchBar.resignFirstResponder()
        
        if segmentedController.selectedSegmentIndex == 0 {
            resultType = ResultType.software
        } else if segmentedController.selectedSegmentIndex == 1 {
            resultType = ResultType.musicTrack
        } else if segmentedController.selectedSegmentIndex == 2 {
            resultType = ResultType.movie
        }
        
        self.searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
