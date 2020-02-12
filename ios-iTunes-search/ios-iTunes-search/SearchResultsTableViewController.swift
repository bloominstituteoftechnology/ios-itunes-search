//
//  SearchResultsTableViewController.swift
//  ios-iTunes-search
//
//  Created by Lambda_School_Loaner_268 on 2/11/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    let searchResultsController = SearchResultController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        let index = indexPath.row

        // Configure the cell...
        let result = searchResultsController.searchResults[index]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    


    func performSearch() {
        guard let searchTerm = searchBar.text,
        searchTerm != "" else { return }

        var resultType: ResultType!

    switch segmentedController.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
    }

    searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
        guard error == nil else {
            print(error)
            return
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
    }
}


extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
}
    


