//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Jordan Christensen on 9/4/19.
//  Copyright © 2019 Mazjap Co Technologies. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    let searchResultController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemSearchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        let result = searchResultController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = itemSearchBar.text else { return }
        
        var type = ResultType.software
        switch typeSegmentedControl.selectedSegmentIndex {
        case 0:
            type = .software
        case 1:
            type = .musicTrack
        case 2:
            type = .movie
        default:
            type = .software
        }
        
        searchResultController.performSearch(searchTerm: searchTerm, resultType: type, completion: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}
