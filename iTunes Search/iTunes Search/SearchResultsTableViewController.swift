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
        switch resultTypeIndex {
        case 1:
            return .musicTrack
        case 2:
            return .movie
        default:
            return .software
        }
    }
    
    var searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath)
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    private func search() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else { return }
        searchBar.resignFirstResponder()
        
        searchResultsController.performSearch(with: searchTerm, resultType: currentResultType) { (error) in
            if let error = error {
                print("Error fetching search results: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func resultTypeChanged(_ sender: UISegmentedControl) {
        search()
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }
}
