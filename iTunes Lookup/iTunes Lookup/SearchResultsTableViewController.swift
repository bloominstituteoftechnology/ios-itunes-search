//
//  TableViewController.swift
//  iTunes Lookup
//
//  Created by Austin Cole on 12/5/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchLabel.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchLabel.text, searchLabel.text != nil else {return}
            var resultType: ResultType!
            let index = appsMusicMovies.selectedSegmentIndex
        switch index {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            return
        }
        searchResultController.performSearch(with: searchTerm, result: resultType) {_ in DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        
        }
    }
    
    let reuseIdentifier = "cell"
    
    
    @IBOutlet weak var searchLabel: UISearchBar!
    
    @IBOutlet weak var appsMusicMovies: UISegmentedControl!

    override func numberOfSections(in tableView: UITableView) -> Int {
        print(searchResultController.searchResults.count)
        return searchResultController.searchResults.count
    }
    
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        TableViewCellController.shared.workLabel.text = searchResultController.searchResults[indexPath.row].title
        
        TableViewCellController.shared.artistLabel.text = searchResultController.searchResults[indexPath.row].creator
        
        return cell
    }
    let searchResultController = SearchResultController()
    
}
