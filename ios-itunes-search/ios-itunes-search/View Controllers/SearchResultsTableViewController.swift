//
//  SearchResultsTableViewController.swift
//  ios-itunes-search
//
//  Created by De MicheliStefano on 07.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Actions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchSearchResults()
    }
    
    @IBAction func selectedSegment(_ sender: Any) {
        fetchSearchResults()
    }
    
    
    private func fetchSearchResults() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        let resultType = getResultTypes(for: segmentedControl.selectedSegmentIndex)
        
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if error != nil {
                NSLog("Error occured while fetching search results: \(String(describing: error))")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func getResultTypes(for index: Int) -> ResultType {
        switch index {
        case 0:
            return ResultType.software
        case 1:
            return ResultType.musicTrack
        case 2:
            return ResultType.movie
        default:
            return ResultType.software
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        let searchResult = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettingsModal" {
            guard let settingsVC = segue.destination as? SettingsViewController else { return }
            settingsVC.searchResultController = self.searchResultController
        } else if segue.identifier == "ShowSearchResultDetail" {
            guard let detailVC = segue.destination as? SearchResultDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            detailVC.searchResult = searchResultController.searchResults[indexPath.row]
        }
    }
    
    // MARK: - Properties
    
    let searchResultController = SearchResultController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    

}
