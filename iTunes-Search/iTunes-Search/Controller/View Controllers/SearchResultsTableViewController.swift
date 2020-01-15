//
//  SearchResultsTableViewController.swift
//  iTunes-Search
//
//  Created by Kenny on 1/14/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    //MARK: IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: IBActions
    @IBAction func categoryWasChanged(_ sender: Any) {
        search()
    }
    
    //MARK: Class Properties
    private let searchController = SearchController()
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    //MARK: Helper Methods
    func search() {
        guard let searchBarText = searchBar.text,
            searchBarText != ""
        else {return}
        
        var resultType: ResultType
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default: resultType = .software
        }
        
        searchController.performSearch(searchTerm: searchBarText, resultType: resultType) { (error) in
            if let error = error {
                print(error)
            } else {
                print(self.searchController.searchResults)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleTableViewCell", for: indexPath)
        let searchResult = searchController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }
}
