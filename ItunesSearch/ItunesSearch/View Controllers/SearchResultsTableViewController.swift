//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by brian vilchez on 9/4/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    @IBOutlet weak var itunesPreference: UISegmentedControl!
    var resultType: ResultType?
  
    @IBOutlet weak var searchBar: UISearchBar!
    var searchResultsController = SearchResultController()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.artistSearchedResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItunesItemCell", for: indexPath) as? ItemTableViewCell else {return UITableViewCell() }
        let artist = searchResultsController.artistSearchedResults[indexPath.row]
        cell.artist = artist
        return cell
    }

}
extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchTerm = searchBar.text else {return}

        switch itunesPreference.selectedSegmentIndex {
        case 0: resultType = .software
        case 1: resultType = .musicTrack
        case 2 : resultType = .movie
        default: break
        }
        print(resultType ?? .movie)
        searchResultsController.performSearch(with: searchTerm, resultType: resultType!) { error in
            
            if let error = error {
                NSLog("cannot load searched Items: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
