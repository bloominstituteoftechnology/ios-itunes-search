//
//  SearchResultsTableViewController.swift
//  iTunes
//
//  Created by Hayden Hastings on 5/14/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iTunesSearchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
            searchTerm != "" else { return }
        
        switch iTunesSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) {_ in 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
    
    
    @IBOutlet weak var iTunesSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var iTunesSearchBar: UISearchBar!
    
    var resultType: ResultType!
    let searchResultsController = SearchResultController()
}
