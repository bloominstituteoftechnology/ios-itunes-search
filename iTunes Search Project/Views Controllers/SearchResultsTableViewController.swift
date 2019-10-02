//
//  SearchResultsTableViewController.swift
//  iTunes Search Project
//
//  Created by macbook on 10/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var searchTypeSegControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    //MARK: - SearchBarButtonClicked
    // set the searchBar's delegate to this class, inside the viewDidLoad
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        var resultType: ResultType!
        
        switch searchTypeSegControl.selectedSegmentIndex {
        case 0 :
            resultType = .software
        case 1 :
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            print("Something wrong with the resultType swith in the segmented control button clicked")
        }
        
        // PerformSearch()
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        
        cell.searchResult = searchResultsController.searchResults[indexPath.row]

        return cell
    }
}
