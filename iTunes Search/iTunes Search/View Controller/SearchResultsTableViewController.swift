//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Kat Milton on 7/9/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var sortTypeSegmentedControl: UISegmentedControl!
    
    let searchResultsController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        

        return cell
    }
    
    @IBAction func searchByCategory(_ sender: UISegmentedControl) {
        updateSearch()
    }
    
    private func updateSearch() {
        var resultType: ResultType!
        switch sortTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        guard let searchTerm = searchBar.text else { return }
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            guard let resultDetailVC = segue.destination as? ResultDetailViewController, let index = tableView.indexPathForSelectedRow else { return }
            let searchResult = searchResultsController.searchResults[index.row]
            resultDetailVC.searchResult = searchResult
        }
    }

    

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateSearch()
    }
    
    
}
