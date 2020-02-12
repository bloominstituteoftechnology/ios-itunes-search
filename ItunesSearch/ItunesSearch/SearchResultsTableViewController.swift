//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Keri Levesque on 2/11/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    //MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    let searchResultsController = SearchResultController()
    var resultType: ResultType!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }

    // MARK: - Table view data source
 
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
 extension SearchResultsTableViewController: UISearchBarDelegate {
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       guard let searchTerm = searchBar.text else { return }
       switch segmentedControl.selectedSegmentIndex {
       case 0:
           resultType = .software
       case 1:
           resultType = .musicTrack
       case 2:
           resultType = .movie
       default:
           break
       }
       searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
   }
 }
