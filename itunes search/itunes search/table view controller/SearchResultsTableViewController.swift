//
//  TableViewController.swift
//  itunes search
//
//  Created by ronald huston jr on 5/4/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentedControlSwitch: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        guard let resultCell = cell as? ResultsTableViewCell else { return cell }
        
        resultCell.titleLabel.text = searchResultController.searchResults[indexPath.row].title
        resultCell.subtitleLabel.text = searchResultController.searchResults[indexPath.row].creator
        return resultCell
    }

    func search(searchTerm: String) {
        var resultType: ResultType!
        
        switch self.segmentedControlSwitch.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            print("Error")
        }
        
        
        self.searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType, completion: { error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                 
                self.tableView.reloadData()
            }
        })
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        search(searchTerm: searchTerm)
    }
    
    func searchBar(_ searchBar: UISearchBar, searchText: String) {
        if searchText.isEmpty {
            searchResultController.searchResults = []
            return
        }
    }
}

