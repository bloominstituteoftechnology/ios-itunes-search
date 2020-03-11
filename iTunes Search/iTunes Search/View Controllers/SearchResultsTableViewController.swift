//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Mark Gerrior on 3/10/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Actions

    @IBAction func segmentControlPressed(_ sender: Any) {
        performSearch()
    }
    
    // MARK: - Proprerties
    private let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    func performSearch() {
        guard let searchTerm = searchBar.text else { return }
        guard let index = typeSegmentControl?.selectedSegmentIndex else { return }
        
        var resultType: ResultType
        
        switch index {
        case 0:
            resultType = .software
        case 1:
            resultType = .music
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { error in
            if let error = error {
                NSLog("Search failed \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)

        // Configure the cell...
        let title = searchResultsController.searchResults[indexPath.row].title ?? "< Missing Title >"
        let creator = searchResultsController.searchResults[indexPath.row].creator ?? "< Missing Creator >"
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = creator
        
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
}
