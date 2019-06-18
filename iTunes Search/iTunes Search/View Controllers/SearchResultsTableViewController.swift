//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Jake Connerly on 6/18/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    //
    //MARK: IBOutlets and Properties
    //
    
    @IBOutlet weak var searchGroupSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSearchBar.delegate = self
    }
    
    //
    // MARK: - Table view data source
    //
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var resultType: ResultType!
        switch searchGroupSegmentedControl.selectedSegmentIndex {
            case 0:
                resultType = .software
            case 1:
                resultType = .musicTrack
            case 2:
                resultType = .movie
            default:
                resultType = .musicTrack
        }
        guard let searchTerm = userSearchBar.text else { return }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
