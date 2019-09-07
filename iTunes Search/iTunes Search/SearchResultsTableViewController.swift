//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Dillon P on 9/7/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchCategory: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    

    override func viewDidLoad() {
        searchBar.delegate = self
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        if let titleLabel = cell.textLabel, let artistLabel = cell.detailTextLabel {
            titleLabel.text = searchResult.title
            artistLabel.text = searchResult.creator
        }
        
        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        switch searchCategory.selectedSegmentIndex {
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
