//
//  TableViewController.swift
//  iTunes Lookup
//
//  Created by Austin Cole on 12/5/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResult = SearchResult.SearchResults.init(results: SearchResultController.shared.searchResults )
    
    let reuseIdentifier = "cell"
    
    
    @IBOutlet weak var searchLabel: UISearchBar!
    
    @IBOutlet weak var appsMusicMovies: UISegmentedControl!

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SearchResultController.shared.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        TableViewCellController.shared.workLabel.text = searchResult.results[indexPath.row].title
        TableViewCellController.shared.artistLabel.text = searchResult.results[indexPath.row].creator
        
        return cell
    }
    
}
