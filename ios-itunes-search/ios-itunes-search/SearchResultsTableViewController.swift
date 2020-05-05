//
//  SearchResultsTableViewController.swift
//  ios-itunes-search
//
//  Created by Ahava on 5/1/20.
//  Copyright © 2020 Ahava. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var itunesSearchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itunesSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itunesCell", for: indexPath) as UITableViewCell

        let item = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.creator

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        performSearch()
    }
    
    @IBAction func changedSegent(_ sender: UISegmentedControl) {
        
        performSearch()
    }
    
    func performSearch() {
        let resultType: ResultType
        
        if resultTypeSegmentedControl.selectedSegmentIndex == 0 {
            resultType = .software
        } else if resultTypeSegmentedControl.selectedSegmentIndex == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        
        guard let searchTerm = itunesSearchBar.text else { return }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error searching: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
