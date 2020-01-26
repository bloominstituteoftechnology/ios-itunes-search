//
//  SearchResultsTableViewController.swift
//  Itunes Search
//
//  Created by Morgan Smith on 1/17/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
   private let searchResultsController = SearchResultController()
    
    
    @IBOutlet weak var typeSelection: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         searchBar.delegate = self
     }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchResult = searchBar.text else {
            return
        }
        
        var resultType: ResultType!
        
        switch typeSelection.selectedSegmentIndex {
        case 0:
            return resultType = .software
        case 1:
            return resultType = .musicTrack
        case 2:
            return resultType = .movie
        default:
           break
        }
        
        searchResultsController.performSearch(searchTerm: searchResult, resultType: resultType) { (error) in
            guard error == nil else {
                print("Error searching: \(error!)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        guard indexPath.row < searchResultsController.searchResults.count else {return cell}
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        return cell
    }
    
    
}
