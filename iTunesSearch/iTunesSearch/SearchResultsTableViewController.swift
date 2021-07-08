//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Yvette Zhukovsky on 10/22/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultsController = SearchResultController()
    
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        var resultType: ResultType!
        if segControl.selectedSegmentIndex == 0 {
            resultType = .software
        }
        else if segControl.selectedSegmentIndex == 1 {
            resultType = .musicTrack
        }   else if segControl.selectedSegmentIndex == 2 {
            resultType = .movie
            
        }
       
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { results,error in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        return cell
    }
    
    
}
