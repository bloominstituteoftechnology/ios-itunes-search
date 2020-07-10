//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Norlan Tibanear on 7/9/20.
//  Copyright © 2020 Norlan Tibanear. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet var segmentButton: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    var searchResultController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBar = searchBar.text, !searchBar.isEmpty else { return }
        
        var resultType: ResultType!
        
        switch segmentButton.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        searchResultController.performSearch(for: searchBar, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        let searchResult = searchResultController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
    

    

  

}
