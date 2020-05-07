//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Ian French on 5/6/20.
//  Copyright © 2020 Ian French. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var searchResultController = SearchResultController()
    
    
    
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
        return searchResultController.searchResults.count
       }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Result Cell", for: indexPath)

         // Configure the cell...
        let searchResult = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        return cell
     }


}


extension SearchResultsTableViewController: UISearchBarDelegate {
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          guard let searchTerm = searchBar.text else { return }
          searchBar.resignFirstResponder()
          
         
        var resultType: ResultType!
        switch segmentControl.selectedSegmentIndex {
            case 0: resultType = .software
            case 1: resultType = .musicTrack
            case 2: resultType = .movie
            default:
                print("Invalid result type")
        
        }
        
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
            self.tableView.reloadData()
              }
          }
      }
   }
