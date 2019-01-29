//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Paul Yi on 1/29/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    // Step-by-step implementation of searchBarSearchButtonClicked
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 1
        guard let search = searchBar.text, search.count > 0 else { return }
        // 2
        var resultType: ResultType!
        let index = segmentedControl.selectedSegmentIndex
        
        // 3
        if index == 0 {
            resultType = .software
        } else if index == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        
        // 4
        searchResultsController.performSearch(searchTerm: search, resultType: resultType) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }

}
