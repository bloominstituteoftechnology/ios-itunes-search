//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Claudia Contreras on 3/13/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet var searchSegmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK: - Properties
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: - IBActions
    @IBAction func selectorItemSelected(_ sender: Any) {
        searchResultsController.searchResults = []
        conductSearch()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        let search = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = search.title
        cell.detailTextLabel?.text = search.creator
        
        return cell
    }


    
    // MARK: - Functions
    func conductSearch() {
        guard let searchTerm = searchBar.text  else { return }
        var resultType: ResultType!
        
        switch searchSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .music
        case 2:
            resultType = .movie
        default:
            break
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        conductSearch()
        
    }
    
}
