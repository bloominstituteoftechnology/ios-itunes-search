//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Zack Larsen on 12/3/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
       let searchResult = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

    }
    
}
    extension SearchResultsTableViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { guard let searchTerm = searchBar.text else { return }
            
        
            var resultType: ResultType!
    
        searchBarSearchButtonClicked()
            switch resultType {
            case "Apps":
                selectedSegmentIndex
            case "Music":
            case "Movies":
            }
        
    }

}
