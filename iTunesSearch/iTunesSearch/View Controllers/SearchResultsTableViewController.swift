//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Niranjan Kumar on 10/29/19.
//  Copyright © 2019 Nar LLC. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var selectionBar: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResultsController = SearchResultController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }

        cell.result = searchResultsController.searchResults[indexPath.row]

        return cell
    }

}


extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }

        var resultType: ResultType!

        switch selectionBar.selectedSegmentIndex {
        case 0:
             resultType = .software
        case 1:
             resultType = .musicTrack
        case 2:
             resultType = .movie
        default:
            return resultType = nil
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
