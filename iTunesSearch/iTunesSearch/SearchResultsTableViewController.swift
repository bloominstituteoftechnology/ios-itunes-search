//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Carolyn Lea on 8/7/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate
{
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    let searchResultController = SearchResultController()
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        //var resultType: ResultType!
        searchResultController.performSearch(with: searchTerm, resultType: .movie) {  (items, error) in
            self.searchResultController.searchResults = self.searchResultController.searchResults
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)

        let result = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    
    
    

}
