//
//  SearchTableViewController.swift
//  iTunes Search
//
//  Created by Eoin Lavery on 16/03/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mediaTypeSegmentedControl: UISegmentedControl!
    
    //MARK: - Properties
    let searchResultsController = SearchResultController()
    var segmentIndex = 0
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    //MARK: - Private Functions
    private func resetSearch() {
        searchBar.text = nil
        searchResultsController.searchResults = []
        tableView.reloadData()
    }
    
    private func performSearch() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            print("Invalid Search Term in searchBar.")
            return
        }
        
        var resultType: ResultType
        
        switch mediaTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .music
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            guard error == nil else {
                print("Error retrieving data from API: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    //MARK: - IBActions
    
    @IBAction func segmentedControlWasTapped(_ sender: Any) {
        let previousSegment = segmentIndex
        let newSegment = mediaTypeSegmentedControl.selectedSegmentIndex
        
        if newSegment != previousSegment {
            resetSearch()
            performSearch()
        }
    }
    
}

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearch()
    }
    
}
