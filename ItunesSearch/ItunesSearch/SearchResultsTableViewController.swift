//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Clean Mac on 5/6/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

//Outlets
@IBOutlet weak var segmentController: UISegmentedControl!

@IBOutlet weak var searchBar: UISearchBar!

//Properties
var searchResultController = SearchResultController()

//LifeCycle
override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
}

//Tableview Data Source
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
        switch segmentController.selectedSegmentIndex{
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

    
