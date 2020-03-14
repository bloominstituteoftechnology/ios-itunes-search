//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Juan M Mariscal on 3/13/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var resultsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var resultsSearchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsSearchBar.delegate = self
   
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)
        
        let results = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = results.title
        cell.detailTextLabel?.text = results.creator

        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        let segmentedResult = resultsSegmentedControl.selectedSegmentIndex
        
        switch segmentedResult {
        case 0:
            print("Chose App segment")
            resultType = .software
        case 1:
            print("Chose Music segment")
            resultType = .music
        case 2:
            print("Chose Movie segment")
            resultType = .movie
        default:
            return
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            guard error == nil else {
                print("Error performingSearch: \(error!)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
