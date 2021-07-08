//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Farhan on 9/11/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        var resultType: ResultType!
        
        let currentSegment = segmentedControl.selectedSegmentIndex
        switch currentSegment {
        case 0:
            resultType = ResultType.software
            break
        case 1:
            resultType = ResultType.musicTrack
            break
        case 2:
            resultType = ResultType.movie
            break
        default:
            return
        }
        searchResultsController.performSearch(searchTerm: searchText, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Searching Error: \(error)")
                return
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.endEditing(true)
                }
            }
        }
    }
}
