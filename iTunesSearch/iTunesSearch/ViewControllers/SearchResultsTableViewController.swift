//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Clayton Watkins on 5/6/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var resultTypeSegmentedController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var searchResultController = SearchResultController()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResult.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let searchResult = searchResultController.searchResult[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        var resultType: ResultType!
        switch resultTypeSegmentedController.selectedSegmentIndex{
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            print("Could not find result type")
        }
        searchResultController.performSearch(searchTerm: searchText, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
