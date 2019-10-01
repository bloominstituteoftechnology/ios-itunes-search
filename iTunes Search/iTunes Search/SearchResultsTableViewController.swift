//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Isaac Lyons on 10/1/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var category: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Properties
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: Private
    
    private func search() {
        guard let searchTerm = searchBar.text,
            searchTerm != "" else { return }
        
        let resultType: ResultType
        switch category.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: Search Bar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }

    //MARK: Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)

        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    //MARK: Actions
    
    @IBAction func categoryChanged(_ sender: UISegmentedControl) {
        search()
    }
    
}
