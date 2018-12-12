//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Sameera Leola on 12/11/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchSegmentedControl: UISegmentedControl!
    @IBOutlet weak var itunesSearchBar: UISearchBar!
    
    //let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itunesSearchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SearchResultController.shared.searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        
        let searchResult = SearchResultController.shared.searchResult[indexPath.row]
        
        cell.serchResult = searchResult
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        //Get the search text
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        var resultType: ResultType!
        
        let index = searchSegmentedControl.selectedSegmentIndex
        
        switch index {
        case 0:
            resultType = ResultType.software
        case 1:
            resultType = ResultType.musicTrack
        case 3:
            resultType = ResultType.movie
        default:
            resultType = ResultType.software
        }
        
        //Get the data
        SearchResultController.shared.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    

}
