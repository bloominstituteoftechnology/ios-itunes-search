//
//  SearchReesultsTableViewController.swift
//  iTunes Search
//
//  Created by Sammy Alvarado on 7/9/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class SearchReesultsTableViewController: UITableViewController {


    @IBOutlet weak var termSelector: UISegmentedControl!
    @IBOutlet weak var termSearch: UISearchBar!

    let searchResultsController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
        termSearch.delegate = self

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTermCell", for: indexPath)

        // Configure the cell...
        let result = searchResultsController.searchResults[indexPath.row]
        cell.detailTextLabel?.text = result.creator
        cell.textLabel?.text = result.title

        return cell
    }

}

extension SearchReesultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var resultType: ResultType!

        switch termSelector.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }


        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
