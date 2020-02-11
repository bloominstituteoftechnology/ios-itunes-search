//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Tobi Kuyoro on 11/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var selectedType: UISegmentedControl!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        
        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        switch selectedType.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(for: searchTerm, ofType: resultType) { (error) in
            if let error = error {
                print("Error fetching results: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
