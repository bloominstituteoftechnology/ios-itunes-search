//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Chris Gonzales on 2/11/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: - Properties
    
    let searchResultsController = SearchResultController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func changedSegment(_ sender: Any) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    // MARK: -View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
   
    }
    // MARK: - Methods
    
    func segmentedFilter() -> ResultType {

        var results: ResultType!

        switch segmentedControl.selectedSegmentIndex{
        case 0:
            results = .software
        case 1:
            results = .movie
        case 2:
            results = .musicTrack
        default:
            break
        }
        return results
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? ResultsTableViewCell else { return UITableViewCell() }
        let result = searchResultsController.searchResults[indexPath.row]
        cell.result = result
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchResultsController.performSearch(searchTerm: searchText, resultType: segmentedFilter()) { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
}


