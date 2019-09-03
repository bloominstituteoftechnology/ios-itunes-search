//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by admin on 9/3/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchSegmentController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultController = SearchResultController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchItemTableViewCell else { return UITableViewCell() }
        
        cell.searchResult = searchResultController.searchResults[indexPath.row]

        return cell
    }

}
extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        if searchSegmentController.selectedSegmentIndex == 0 {
            resultType = ResultType.software
        } else if searchSegmentController.selectedSegmentIndex == 1 {
            resultType = ResultType.musicTrack
        } else {
            resultType = ResultType.movie
        }
        
        searchResultController.performSearch(with: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
