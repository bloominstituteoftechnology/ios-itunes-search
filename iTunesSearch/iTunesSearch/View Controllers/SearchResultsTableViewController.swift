//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Rob Vance on 5/6/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

// Mark: IBOutlets
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
// Mark: Properties
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)
        
        let resultOfSearch = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = resultOfSearch.title
        cell.detailTextLabel?.text = resultOfSearch.creator

        return cell
    }

}
extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        var resultType: ResultType!
        
        switch segmentController.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            print("Couldn't find result type")
        }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        }
    }
}
