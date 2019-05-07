//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Christopher Aronson on 5/7/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    let searchResultsController = SearchResultsController()

    @IBOutlet weak var resultTypeSegmentController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }

        cell.searchResult = searchResultsController.searchResults[indexPath.row]

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        switch resultTypeSegmentController.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            print("That is not a valid option")
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }


}
