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
        searchBar.delegate = self

    
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as? SearchResultsTableViewCell else { return UITableViewCell()}

        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.searchResult = searchResult
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
            break
        }
    
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType){ error in
            if let error = error {
               NSLog("Error in search: \(error)")
            } else {
                DispatchQueue.main.async {
                self.tableView.reloadData()
           }
        }
     }
   }
}

