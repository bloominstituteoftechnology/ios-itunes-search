//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Ciara Beitel on 9/3/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var mediaSegCon: UISegmentedControl!
    
    @IBOutlet weak var searchMedia: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchMedia.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mediaItemCell", for: indexPath) as? SearchResultsTableViewCell else { return UITableViewCell() }
        
        cell.mediaItemResult = searchResultsController.searchResults[indexPath.row]
        
        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        switch mediaSegCon.selectedSegmentIndex {
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
                NSLog("\(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
