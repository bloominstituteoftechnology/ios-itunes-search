//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Kat Milton on 6/18/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet var categorySelector: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    var searchResultsController = SearchResultController()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath)

        // Configure the cell...
        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    

   

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        var resultType: ResultType!
        switch categorySelector.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
}
