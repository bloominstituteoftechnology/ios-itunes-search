//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Bhawnish Kumar on 3/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResultController = SearchResultController()
    override func viewDidLoad() {
        super.viewDidLoad()
 searchBar.delegate = self
        self.tableView.reloadData()
        
    }

    @IBAction func segmentedControl(_ sender: Any) {
    searchBarSearchButtonClicked(searchBar)
        self.tableView.reloadData()
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)
        let result = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        // Configure the cell...

        return cell
    }
    

   
}

extension  SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType!
        guard let resultType1 = resultType else { return }
        
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
    
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType1) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
