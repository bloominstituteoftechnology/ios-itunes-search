//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Jeffrey Carpenter on 5/7/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResultsController = SearchResultController()

    @IBOutlet weak var contentTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)
        cell.textLabel?.text = searchResultsController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultsController.searchResults[indexPath.row].creator

        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType
        
        switch contentTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.view.endEditing(true)
                self.tableView.reloadData()
            }
        }
    }
}
