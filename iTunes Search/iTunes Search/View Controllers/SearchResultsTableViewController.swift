//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Madison Waters on 12/4/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var resultType: ResultType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        Model.shared.updateHandler = { self.tableView.reloadData() }
    }
    
    deinit {
        Model.shared.updateHandler = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        Model.shared.searchItunes(with: searchTerm)
        
        switch searchTypeSegmentControl.selectedSegmentIndex {
        case 0:
            resultType = ResultType.software
        case 1:
            resultType = ResultType.musicTrack
        case 2:
            resultType = ResultType.movie
        default:
            break
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Model.shared.numberOfResults()
    }

    let reuseIdentifier = "SearchItemCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let searchResult = Model.shared.getSearchResult(at: indexPath.row)
        cell.textLabel?.text = searchResult.artist
        cell.detailTextLabel?.text = searchResult.title

        return cell
    }
}
