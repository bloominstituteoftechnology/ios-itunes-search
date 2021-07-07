//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Daniela Parra on 9/11/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        var resultType: ResultType!
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = ResultType.software
        case 1:
            resultType = ResultType.musicTrack
        case 2:
            resultType = ResultType.movie
        default:
            break
        }
        
        searchResultController.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        cell.textLabel?.text = searchResultController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultController.searchResults[indexPath.row].creator
        
        return cell
    }

    var searchResultController = SearchResultController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
}
