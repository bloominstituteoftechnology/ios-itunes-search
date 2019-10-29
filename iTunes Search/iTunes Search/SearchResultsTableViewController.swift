//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Jon Bash on 2019-10-29.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTypeControl: UISegmentedControl!
    
    var currentResultType: ResultType {
        let resultTypeIndex = resultTypeControl.selectedSegmentIndex
        return ResultType.allCases[resultTypeIndex]
    }
    
    var searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath)
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    func performSearch() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else { return }
        
        searchResultsController.performSearch(with: searchTerm, resultType: currentResultType) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching search results: \(error)")
                }
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func resultTypeChanged(_ sender: UISegmentedControl) {
        performSearch()
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
}
