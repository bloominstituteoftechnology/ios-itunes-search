//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Scott Bennett on 9/18/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pickCategory: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResutlsController = SearchResultController()
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResutlsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)

       let searchResult = searchResutlsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType!
        
        switch pickCategory.selectedSegmentIndex {
        case 0:
            resultType = ResultType.software
        case 1:
            resultType = ResultType.musicTrack
        case 2:
            resultType = ResultType.movie
        default:
            break
        }
        
        searchResutlsController.performSearch(with: searchTerm, resultType: resultType) { (_, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
     
        
        
    }
    
}
