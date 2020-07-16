//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by B$hady on 7/8/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
        let searchResultController = SearchResultController()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            searchBar.delegate = self
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResultController.searchResults.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
            
            let searchResult = searchResultController.searchResults[indexPath.row]

            // Configure the cell...
            cell.textLabel?.text = searchResult.title
            cell.detailTextLabel?.text = searchResult.creator
            
            return cell
        }
   }


    extension SearchResultsTableViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchTerm = searchBar.text else { return }
            searchBar.resignFirstResponder()
            let resultType: ResultType!
            switch segmentedController.selectedSegmentIndex {
            case 0:
                resultType = ResultType.software
            case 1:
                resultType = ResultType.musicTrack
            default:
                resultType = ResultType.movie
            }
            searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { error in
                if let error = error {
                    print("Search error: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
