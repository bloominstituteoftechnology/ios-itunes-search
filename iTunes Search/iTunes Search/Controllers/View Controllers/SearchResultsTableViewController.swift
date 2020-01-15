//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Aaron Cleveland on 1/15/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultController = SearchResultController()
    var resultType: ResultType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        let result = searchResultController.searchResults[indexPath.row]
        cell.results = result
        return cell
    }
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBar = searchBar.text,
            searchBar != ""
        else {return}
        
        var resultType: ResultType
        switch segmentControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default: resultType = .software
        }
        
        searchResultController.performSearch(searchTerm: searchBar, resultType: resultType) { (error) in
            if let error = error {
                print("Error \(error)")
            } else {
                print(self.searchResultController.searchResults)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

