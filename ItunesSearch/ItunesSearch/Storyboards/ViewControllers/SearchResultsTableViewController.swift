//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Nonye on 5/4/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let searchResult = searchResultsController.searchResults[indexPath.row]
    
        return cell
    }
    
    
    
}
extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        // MARK: - IMPLEMENTATION OF SEARCH BAR
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .musicTrack
        }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { _ in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
}
