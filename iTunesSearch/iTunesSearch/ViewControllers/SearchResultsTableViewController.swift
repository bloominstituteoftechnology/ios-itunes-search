//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Shawn Gee on 3/10/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var resultTypeSelector: UISegmentedControl!
    private let resultTypeOptions: [ResultType] = [.software, .movie, .musicTrack]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Properties
    
    private var searchResultController = SearchResultController()
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        let result = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
}


//MARK: - Search Bar Delegate

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        let resultType = resultTypeOptions[resultTypeSelector.selectedSegmentIndex]
        
        searchResultController.performSearch(withTerm: searchTerm, resultType: resultType) { error in
            if let error = error {
                // We should really let the user know that we are unable to fetch results for whatever reason
                NSLog("There was an error when attempting to search: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
