//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Nathanael Youngren on 1/22/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        let selectedIndex = categorySelector.selectedSegmentIndex
        
        runSearch(searchTerm: searchTerm, selectedIndex: selectedIndex)
    }
    
    @IBAction func changeSelectedType(_ sender: UISegmentedControl) {
        guard let searchTerm = searchField.text, !searchTerm.isEmpty else { return }
        
        let selectedIndex = sender.selectedSegmentIndex
        
        runSearch(searchTerm: searchTerm, selectedIndex: selectedIndex)
        
    }
    
    func runSearch(searchTerm: String, selectedIndex: Int) {
        var resultType: ResultType!
        
        switch selectedIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (results, error) in
            DispatchQueue.main.async {
                self.results = results ?? []
                self.tableView.reloadData()
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        cell.textLabel?.text = results[indexPath.row].title
        cell.detailTextLabel?.text = results[indexPath.row].creator

        return cell
    }
    
    var searchResultsController = SearchResultController()
    
    var results: [SearchResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var categorySelector: UISegmentedControl!
    @IBOutlet weak var searchField: UISearchBar!

}
