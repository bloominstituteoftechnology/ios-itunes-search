//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Jeffrey Carpenter on 5/7/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResultsController = SearchResultController()
    
    var resultType: ResultType {
        get {
            switch contentTypeSegmentedControl.selectedSegmentIndex {
            case 0:
                return .software
            case 1:
                return .musicTrack
            case 2:
                return .movie
            default:
                return .software
            }
        }
    }

    @IBOutlet weak var contentTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    @IBAction func contentTypeValueChanged(_ sender: UISegmentedControl) {
        performSearch()
    }
    
    private func performSearch() {
        
        guard let searchTerm = searchBar.text else { return }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.view.endEditing(true)
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowMovieDetail" {
            guard let destinationVC = segue.destination as? MovieDetailViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else { return }
            
            destinationVC.searchResult = searchResultsController.searchResults[index]
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)
        let searchResult: SearchResult = searchResultsController.searchResults[indexPath.row]
        cell.isUserInteractionEnabled = false
        
        // Set the textLabel to title or collection (if title == nil) or "" (if title && collection == nil)
        if let title = searchResult.title {
            cell.textLabel?.text = title
            
            // Add ability to select cell if type is a single movie
            if resultType == .movie {
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .default
                cell.isUserInteractionEnabled = true
            }
        } else if let collection = searchResult.collection {
            cell.textLabel?.text = collection
        } else {
            cell.textLabel?.text = ""
        }
        
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
}
