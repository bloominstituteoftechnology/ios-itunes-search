//
//  SearchReultsTableViewController.swift
//  itunes Search
//
//  Created by Gi Pyo Kim on 10/1/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class SearchReultsTableViewController: UITableViewController {
    @IBOutlet weak var appsMusicsMovies: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultController = SearchResultController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.keyboardDismissMode = .onDrag
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        guard let searchTerm = searchBar.text else { return }
        
        var resultType: ResultType!
        
        switch sender.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        
        searchResultController.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error searching \(searchTerm): \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
   }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }

        cell.searchResult = searchResultController.searchResults[indexPath.row]
        
        return cell
    }
}

extension SearchReultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        var resultType: ResultType!
        
        switch appsMusicsMovies.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        
        searchResultController.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error searching \(searchTerm): \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
}
