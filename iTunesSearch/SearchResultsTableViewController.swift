//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Dawn Jones on 5/6/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mediaControl: UISegmentedControl!
    @IBOutlet weak var mediaSearchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mediaSearchBar.delegate = self
    }
    
    @IBAction func mediaControlChanged(_ sender: Any) {
        searchBarSearchButtonClicked(mediaSearchBar)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath)

        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchResultsController.searchResults.removeAll()
        searchBar.resignFirstResponder()
        var resultType: ResultType!
        
        switch mediaControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        self.searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {_ in 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
