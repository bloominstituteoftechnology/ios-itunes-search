//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Shawn Gee on 3/10/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var resultTypeSelector: UISegmentedControl!
    private let resultTypeOptions: [ResultType] = [.software, .movie, .musicTrack]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - IBActions
    
    @IBAction func resultTypeSelected(_ sender: UISegmentedControl) {
        if let lastSearchTerm = lastSearchTerm {
            search(withTerm: lastSearchTerm)
        }
    }
    
    
    //MARK: - Private
    
    private var searchResultController = SearchResultController()
    private var lastSearchTerm: String?
    private var activityIndicator = UIActivityIndicatorView()
    
    private func search(withTerm searchTerm: String) {
        
        let resultType = resultTypeOptions[resultTypeSelector.selectedSegmentIndex]
        
        searchResultController.performSearch(withTerm: searchTerm, resultType: resultType) { error in
            DispatchQueue.main.async {
                
                self.activityIndicator.stopAnimating()
                
                if let error = error {
                    // We should really let the user know that we are unable to fetch results for whatever reason
                    NSLog("There was an error when attempting to search: \(error)")
                }
                
                
                self.tableView.reloadData()
            }
        }
        
        activityIndicator.startAnimating()
        self.tableView.reloadData()
        
        lastSearchTerm = searchTerm
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundView = activityIndicator
    }

    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRows = searchResultController.searchResults.count
        tableView.separatorStyle = numRows == 0 ? .none : .singleLine
        return numRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        let result = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
}


//MARK: - Search Bar Delegate

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        search(withTerm: searchTerm)
        searchBar.resignFirstResponder()
    }
}
