//
//  SearchResultsTableViewController.swift
//  itunes-search
//
//  Created by Jarren Campos on 3/13/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResultsController = SearchResultController()
    
    //MARK: -IBOutlets
    @IBOutlet var segmentedControlSwitch: UISegmentedControl!
    @IBOutlet var searchBarResults: UISearchBar!
    
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarResults.delegate = self
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        
        return cell
    }
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        let resultTypeIndex = segmentedControlSwitch.selectedSegmentIndex
        var resultType: ResultType!
        switch resultTypeIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
