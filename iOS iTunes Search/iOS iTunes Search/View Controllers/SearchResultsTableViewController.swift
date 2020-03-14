//
//  SearchResultsTableViewController.swift
//  iOS iTunes Search
//
//  Created by Elizabeth Thomas on 3/13/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    // MARK: - Properties
    let searchResultsController = SearchResultController()
//    private var searchResults: [SearchResult] = [] {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    // MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.artist

        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        var resultType: ResultType!
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
//            if let error = error {
//                print("Unable to search: \(error)")
//            } else {
                print(self.searchResultsController.searchResults)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
        }
    }
}
