//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Welinkton on 9/19/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

   let searchResultsController = SearchResultController()
 
    @IBOutlet weak var segmentedBar: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)

        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.artist
    
        return cell
    }
    
    // MARK - SearchBar Delegate
    
    // create a var to take in the search bar text
    // and check and see guard if its empty
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        var resultType: ResultType!
        
        // use the segmented control to pick which one you want to search for
        let typeSegment = segmentedBar.selectedSegmentIndex
        
        // switch segment in (swith Segment form)
        switch typeSegment {
        case 0:
            resultType = ResultType.software
        case 1:
            resultType = ResultType.musicTrack
        case 2:
            resultType = ResultType.movie
        default:
            return
        }
        
        
        // call the performSearch Method
        // pass in the searchTerm and resultType
        //
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { ([SearchResult]?, NSError) in
            if let error = NSError {
                NSLog("Error fecthing data: \(error)")
                return
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.endEditing(true)
                }
            }
        }
        
        }
    }

    


