//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by morse on 5/7/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var typePicker: UISegmentedControl!
    
    private let searchResultController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType
        
        switch typePicker.selectedSegmentIndex {
        case 0: resultType = ResultType.software
        case 1: resultType = ResultType.musicTrack
        // Would it be better to create an enum here? There really are only 3 possibilities for the resultType, but the compiler won't consider the switch exhaustive without using "default:".
        default: resultType = ResultType.movie
        }
        
        // Should I be checking for an error on 35? Instead of ignoring it with _?
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func typePickerTapped(_ sender: Any) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        // No cell, so we need to do this explicitly here, correct?
        cell.textLabel?.text = searchResultController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultController.searchResults[indexPath.row].creator

        return cell
    }
}
