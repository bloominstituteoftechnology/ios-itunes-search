//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Alex Rhodes on 9/3/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let searchController = SearchResultsController()
    
    var searchResult: SearchResult? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let searchResult = searchController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        setViews()
    }
    
    func setViews() {
        
        var resultType: ResultType!
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .movie
        case 2:
            resultType = .musicTrack
        default:
            break
        }
        
        guard let searchBarText = searchBar.text else {return}
        
        searchController.preformSearch(with: searchBarText, resultType: resultType) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        setViews()
    }
}
