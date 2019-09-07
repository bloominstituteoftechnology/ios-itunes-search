//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Fabiola S on 9/6/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    var resultType: ResultType {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return .software
        case 1:
            return  .musicTrack
        default:
            return .movie
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        startSearch()
        
    }
    
    @IBAction func typeOfSearch(_ sender: UISegmentedControl) {
        startSearch()
        
    }
   
    func startSearch() {
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                print("Error while performing search: \(error)")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }

}


