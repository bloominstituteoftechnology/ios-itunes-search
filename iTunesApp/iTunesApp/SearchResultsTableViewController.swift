//
//  SearchResultsTableViewController.swift
//  iTunesApp
//
//  Created by Lydia Zhang on 3/10/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    @IBOutlet weak var tapBar: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResultsController = SearchResultController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        
        //let result = searchResultsController.searchResults[indexPath.row]
        //cell.name.text = result.creator
        //cell.title.text = result.title
        cell.searchResult = searchResultsController.searchResults[indexPath.row]

        return cell
    }
    @IBAction func tapBar(_ sender: UISegmentedControl) {
        searchBarSearchButtonClicked(searchBar)
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType?
        
        if tapBar.selectedSegmentIndex == 0 {
            resultType = .software
        } else if tapBar.selectedSegmentIndex == 1 {
            resultType = .musicTrack
        } else if tapBar.selectedSegmentIndex == 2 {
            resultType = .movie
        }
        
        searchResultsController.search(searchTerm: searchTerm, resultType: resultType!, searchLimit: 20) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
