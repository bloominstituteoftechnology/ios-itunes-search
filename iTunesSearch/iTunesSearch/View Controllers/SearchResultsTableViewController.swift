//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by David Wright on 1/17/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: - Properties

    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var mediaTypeSelector: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Action Handlers

    @IBAction func mediaTypeSelectorChanged(_ sender: UISegmentedControl) {
        updateDataSource()
    }
    
    // MARK: - Private Methods
    
    private func resultTypeFor(selectedSegmentIndex: Int) -> ResultType {
        switch selectedSegmentIndex {
        case 0:
            return .software
        case 1:
            return .musicTrack
        default:
            return .movie
        }
    }
    
    private func updateDataSource() {
        guard let searchTerm = searchBar.text,
            let selectedSegmentIndex = mediaTypeSelector?.selectedSegmentIndex else { return }
        
        let resultType = resultTypeFor(selectedSegmentIndex: selectedSegmentIndex)
        
        print("Searching for \(searchTerm)...")
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType, completion: { (error) in
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                print("Found \(self.searchResultsController.searchResults.count) results!")
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultTableViewCell
        
        guard indexPath.row < searchResultsController.searchResults.count else { return cell }
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.searchResult = searchResult
        
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateDataSource()
    }
}
