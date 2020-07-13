//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Dojo on 7/8/20.
//  Copyright © 2020 Dojo. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var appsMoviesSwitch: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResultController = SearchResultController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let searchResult = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.trackName
        cell.detailTextLabel?.text = searchResult.artistName
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        var resultType: ResultType!
        switch appsMoviesSwitch.selectedSegmentIndex{
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            print("Could not find result type")
        }
        
        DispatchQueue.main.async {
            self.searchResultController.performSearch(searchTerm: searchText, resultType: resultType) { (error) in
                if let error = error {
                    print("error fetching data: \(error)")
                    
                }
            }
            self.tableView.reloadData()
            
        }
    }
}
