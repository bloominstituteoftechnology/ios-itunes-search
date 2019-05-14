//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Mitchell Budge on 5/14/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    private let searchResultsController = SearchResultController()
    private var resultType: ResultType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    } // end of view did load

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.results.count
    } // end of number of rows

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        let output = searchResultsController.results[indexPath.row]
        cell.textLabel?.text = output.title
        cell.detailTextLabel?.text = output.creator
        return cell
    } // end of cell for row at
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != ""
            else { return }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        searchResultsController.performSearch(with: searchTerm, and: resultType) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    } // end of search bar 
}
