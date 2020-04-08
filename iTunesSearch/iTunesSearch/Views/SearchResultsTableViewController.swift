//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Chris Dobek on 4/6/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultController = SearchResultController()

    @IBOutlet weak var segmentedControlSwitch: UISegmentedControl!
    @IBOutlet weak var searchBarResults: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultController.delegate = self
        searchBarResults.delegate = self
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        guard let myCell = cell as? ResultsTableViewCell else {
            return cell
        }
        myCell.titleLabel.text = searchResultController.searchResults[indexPath.row].artistName
        myCell.subtitleLabel.text = searchResultController.searchResults[indexPath.row].trackName
        return myCell
}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        switch segmentedControlSwitch.selectedSegmentIndex {
        case 0:
            searchResultController.selectedSegment = .Apps
        case 1:
            searchResultController.selectedSegment = .Music
        case 2:
            searchResultController.selectedSegment = .Movies
        default:
            searchResultController.selectedSegment = .Apps
        }
        guard let text = searchBar.text else { return }
        
        searchResultController.performSearch(searchTerm: text, resultType: .movie) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
        }
}
}
}
extension SearchResultsTableViewController: SearchResultsDelegate {
    func updateTableView() {
        tableView.reloadData()
    }

}
