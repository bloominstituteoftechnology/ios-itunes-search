//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Nathan Hedgeman on 6/9/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: Properties And Outlets
    @IBOutlet weak var resultTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    let cellID = "ResultsCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        var resultType: ResultType!
        let searchType = resultTypeSegmentControl.selectedSegmentIndex
        
        //Handles the results returned to the array
        if searchType == 0 {
            resultType = .software
        } else if searchType == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        
        searchResultsController.performSearch(searchTerm: searchText, resultType: resultType) { (error) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        print(searchResultsController.searchResults)
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
   
}
