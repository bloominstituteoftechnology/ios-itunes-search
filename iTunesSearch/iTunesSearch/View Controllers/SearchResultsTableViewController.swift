//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Nichole Davidson on 3/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as? SearchResultsTableViewCell else { return UITableViewCell()}

        // Configure the cell...
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.searchResult?.title = searchResult.title
        cell.searchResult?.creator = searchResult.creator

        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
    
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType){_ in
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
       }
}


