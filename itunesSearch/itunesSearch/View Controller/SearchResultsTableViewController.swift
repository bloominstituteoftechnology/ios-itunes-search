//
//  SearchResultsTableViewController.swift
//  itunesSearch
//
//  Created by Matthew Martindale on 3/14/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResultController = SearchResultController()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        let searchIndex = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = searchIndex.title
        cell.detailTextLabel?.text = searchIndex.creator
        
        return cell
    }
    
    @IBAction func changedSearchParams(_ sender: Any) {
        searchResultController.searchResults = []
        updateWithNewMediaSearch()
    }
    
    func updateWithNewMediaSearch() {
        guard let searchTerm = searchBar.text,
            searchTerm != "" else { return }
        
        var resultType: ResultType!
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateWithNewMediaSearch()
    }
}

