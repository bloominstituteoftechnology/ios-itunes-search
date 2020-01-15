//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Ufuk Türközü on 14.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
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
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        
        let item = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.creator

        // Configure the cell...

        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
       
        var resultType: ResultType!
        
        if segmentedControl.selectedSegmentIndex == 0 {
            resultType = .software
        } else if segmentedControl.selectedSegmentIndex == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
    
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
        
        if let error = error {
            print("Error \(error)")
            return
        }
        
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
}

