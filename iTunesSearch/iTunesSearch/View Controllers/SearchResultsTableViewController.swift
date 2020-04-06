//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Hunter Oppel on 4/6/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var resultTypeSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    let searchResultsController = SearchResultController()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        cell.textLabel?.text = searchResultsController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultsController.searchResults[indexPath.row].creator

        return cell
    }
    
    private func searchWith(searchTerm: String) {
            var resultType: ResultType!
            
            switch self.resultTypeSegment.selectedSegmentIndex {
            case 0:
                resultType = .software
            case 1:
                resultType = .musicTrack
            case 2:
                resultType = .movie
            default:
                print("Error")
            }
            
            self.searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType, completion: { [weak self] error in
                DispatchQueue.main.async {
                       if let error = error {
                           print(error)
                       }
                       guard let self = self else { return }
                       
                       self.tableView.reloadData()
                }
            })
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        searchWith(searchTerm: searchTerm)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResultsController.searchResults = []
            return
        }
    }
}
