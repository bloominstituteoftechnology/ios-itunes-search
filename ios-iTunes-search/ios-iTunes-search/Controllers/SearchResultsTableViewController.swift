//
//  SearchResultsTableViewController.swift
//  ios-iTunes-search
//
//  Created by Lambda-School-Loaner-11 on 8/7/18.
//  Copyright © 2018 Lambda-School-Loaner-11. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultsController = SearchResultsController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchbar: UISearchBar!
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        var resultType: ResultType!
        
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
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("\(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchbar.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let search = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = search.title
        cell.detailTextLabel?.text = search.creator
        
        return cell
    }
}
