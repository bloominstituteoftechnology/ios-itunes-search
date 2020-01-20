//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Eoin Lavery on 20/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
    }

    // MARK: - Table view data source
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
    
    func performSearch() {
        guard let searchTerm = searchbar.text,
            searchTerm != "" else { return }
        
        var resultType: ResultType!
        
        switch resultTypeSegmentedControl.selectedSegmentIndex {
            case 0:
                resultType = .software
            case 1:
                resultType = .music
            case 2:
                resultType = .movie
            default:
                resultType = nil
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            guard error == nil else {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        performSearch()
    }
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
}
