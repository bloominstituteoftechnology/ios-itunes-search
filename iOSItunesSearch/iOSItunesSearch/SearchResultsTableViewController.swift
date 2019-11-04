//
//  SearchResultsTableViewController.swift
//  iOSItunesSearch
//
//  Created by denis cedeno on 11/3/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedResultsType: UISegmentedControl!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? ResultsTableViewCell else { return UITableViewCell() }
        let result = searchResultsController.searchResults[indexPath.row]
        cell.result = result
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        self.searchResultsController.searchResults.removeAll()
               switch segmentedResultsType.selectedSegmentIndex {
               case 0:
                   resultType = .software
               case 1:
                   resultType = .musicTrack
               case 2:
                   resultType = .movie
               default:
                   return
               }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { error in
            if let error = error {
                print("Unable to fetch data: \(error)")
            }

            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
}
