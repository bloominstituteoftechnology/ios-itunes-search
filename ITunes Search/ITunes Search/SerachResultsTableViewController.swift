//
//  SerachResultsTableViewController.swift
//  ITunes Search
//
//  Created by Sean Acres on 6/18/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import UIKit

class SerachResultsTableViewController: UITableViewController {

    @IBOutlet weak var entitySegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        let result = searchResultsController.searchResults[indexPath.row]
        
        if let title = result.title {
            cell.textLabel?.text = title
        } else {
            cell.textLabel?.text = "Audiobook"
        }
        
        cell.detailTextLabel?.text = result.creator

        return cell
    }
}

extension SerachResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchBar.text != "" else { return }
        var resultType: ResultType!
        
        switch entitySegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                print("\(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}
