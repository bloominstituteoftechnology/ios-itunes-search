//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by John Kouris on 9/7/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        cell.textLabel?.text = searchResultsController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultsController.searchResults[indexPath.row].creator

        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        var resultType: ResultType!
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = ResultType.software
        case 1:
            resultType = ResultType.musicTrack
        case 2:
            resultType = ResultType.movie
        default:
            resultType = ResultType.musicTrack
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            guard error != nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
