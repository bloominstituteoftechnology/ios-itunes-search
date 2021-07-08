//
//  SearchResultsTableViewController.swift
//  Itunes Search
//
//  Created by Iyin Raphael on 9/18/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResutlController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        let search = searchResutlController.searchResults[indexPath.row]
        cell.searchResult = search
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        switch segmentedCtrl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        searchResutlController.performSearch(searchTerm: searchTerm, resultType: resultType) { (result, error) in
        self.searchResutlController.searchResults = result ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        
    }
    
    
    

    
    let searchResutlController = SearchController()
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    

}
