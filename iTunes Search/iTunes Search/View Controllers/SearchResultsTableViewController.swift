//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Chad Parker on 3/13/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!

    private let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func newSegmentSelected(_ sender: Any) {
        performSearch()
    }

    private func performSearch() {
        guard let searchText = searchBar.text else { return }

        var resultType: ResultType!
        switch resultTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }

        tableView.reloadData()

        searchResultsController.performSearch(searchText, resultType: resultType) { error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
}
