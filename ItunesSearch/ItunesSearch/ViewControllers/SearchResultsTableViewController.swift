//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Marissa Gonzales on 5/4/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var category: UISegmentedControl!
    
    let searchResultsController = SearchResultController()
    var resultType: ResultType {
        
        switch category.selectedSegmentIndex {
        case 0:
            return .software
        case 1:
            return .musicTrack
        default:
            return .movie
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func changeResultType(_ sender: Any) {
        startSearch()
    }
    
    
    func searchBarButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        startSearch()
    }
    
    func startSearch() {
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                print("Error performing search: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultsController.searchResults.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
}





