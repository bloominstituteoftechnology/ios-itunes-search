//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Dillon McElhinney on 9/11/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    let searchResultController = SearchResultController()
    
    private var resultType: ResultType {
        let segment = resultTypeSegmentedControl.selectedSegmentIndex
        if segment == 0 {
            return .software
        } else if segment == 1 {
            return .musicTrack
        } else {
            return .movie
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    // MARK: - UI Methods
    @IBAction func changeResultType(_ sender: Any) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let searchResult = searchResultController.searchResults[indexPath.row]

        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
    
    // MARK: - UI Search Bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
