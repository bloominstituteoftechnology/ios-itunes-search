//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Chad Rutherford on 12/3/19.
//  Copyright © 2019 chadarutherford.com. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    let searchResultsController = SearchResultController()
    var resultType: ResultType!
    var searchTerm = ""
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    private func startNewSearch(term: String, resultType: ResultType) {
        
        if searchResultsController.searchResults.count > 0 {
            searchResultsController.searchResults.removeAll()
            tableView.reloadData()
        }
        
        searchResultsController.performSearch(searchTerm: term, resultType: resultType) { error in
            if let error = error {
                print("Error fetching results: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Actions
    @IBAction func resultTypeChanged(_ sender: UISegmentedControl) {
        switch resultTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        startNewSearch(term: searchTerm, resultType: resultType)
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Table View DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)
        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        return cell
    }
}

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - UISearchBar Delegate Extension
extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text, !term.isEmpty else { return }
        searchTerm = term
        startNewSearch(term: searchTerm, resultType: resultType)
    }
}
