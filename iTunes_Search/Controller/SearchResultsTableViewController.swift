//
//  SearchResultsTableViewController.swift
//  iTunes_Search
//
//  Created by Brian Rouse on 5/4/20.
//  Copyright © 2020 Brian Rouse. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

        @IBOutlet weak var searchGroupSegmentedControl: UISegmentedControl!
        @IBOutlet weak var userSearchBar: UISearchBar!
        
        let searchResultsController = SearchResultController()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            userSearchBar.delegate = self
           
        }
        
       
        
        @IBAction func userChangeValue(_ sender: UISegmentedControl) {
            updateViews()
        }
        
        
        //
        // MARK: - Table view data source
        //
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResultsController.searchResults.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
            let searchResult = searchResultsController.searchResults[indexPath.row]
            
            cell.textLabel?.text = searchResult.title
            cell.detailTextLabel?.text = searchResult.creator
            
            return cell
        }
        func updateViews() {
            var resultType: ResultType!
            switch searchGroupSegmentedControl.selectedSegmentIndex {
            case 0:
                resultType = .software
            case 1:
                resultType = .musicTrack
            case 2:
                resultType = .movie
            default:
                resultType = .musicTrack
            }
            guard let searchTerm = userSearchBar.text else { return }
            searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {_ in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

        

    extension SearchResultsTableViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            updateViews()
        }
    }
