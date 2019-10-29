//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Lambda_School_Loaner_204 on 10/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    
    private let searchResultController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(searchResultController.searchResults.count)
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        // Configure the cell...
        let result = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        return cell
    }
 
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        var resultType: ResultType!
        
        switch resultTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = nil
        }
        
        if searchResultController.searchResults.count > 0 {
            searchResultController.searchResults.removeAll()
        }
        
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { error in
            if let error = error {
                print("Error with search: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
