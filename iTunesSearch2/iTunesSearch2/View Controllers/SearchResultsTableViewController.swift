//
//  SearchResultsTableViewController.swift
//  iTunesSearch2
//
//  Created by Clean Mac on 7/12/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    // IBOUTLETS
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell" , for: indexPath)
        
        let searchResultCell = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResultCell.title
        cell.detailTextLabel?.text = searchResultCell.creator
        
        return cell
        
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var segmentSelected: ResultType
        
        switch segmentedController.selectedSegmentIndex {
        case 0:
            segmentSelected = .software
            
        case 1:
            segmentSelected = .musicTrack
            
        case 2:
            segmentSelected = .movie
            
        default:
            return
        }
        
        
        
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: segmentSelected) { (_) in
            DispatchQueue.main.async {
            self.tableView.reloadData()
        }
            
                
            }
        }
    }

