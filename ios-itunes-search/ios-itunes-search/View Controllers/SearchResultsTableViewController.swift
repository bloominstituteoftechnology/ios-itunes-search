//
//  SearchResultsTableViewController.swift
//  ios-itunes-search
//
//  Created by Conner on 8/7/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty,
            let segmentedControlChoice = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex),
            let resultType = ResultType(rawValue: segmentedControlChoice) else { return }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (searchResults, error) in
            self.searchResultsController.searchResults = searchResults ?? []
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let searchResult = searchResultsController.searchResults[indexPath.row]

        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
}
