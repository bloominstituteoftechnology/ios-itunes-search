//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Bronson Mullens on 5/6/20.
//  Copyright © 2020 Bronson Mullens. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    private let searchResultController = SearchResultController()
    var resultType: ResultType!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        switch categorySegmented.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let searchResultCell = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResultCell.title
        cell.detailTextLabel?.text = searchResultCell.creator

        return cell
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var categorySegmented: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
}
