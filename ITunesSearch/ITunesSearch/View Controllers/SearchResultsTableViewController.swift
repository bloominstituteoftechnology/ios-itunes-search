//
//  SearchResultsTableViewController.swift
//  ITunesSearch
//
//  Created by Nick Nguyen on 2/11/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }

    @IBOutlet weak var segment: UISegmentedControl!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

 // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iCell", for: indexPath)
        cell.textLabel?.text = searchResultsController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultsController.searchResults[indexPath.row].creator
        return cell
    }
   

}

//MARK: - SearchBar Delegate
extension SearchResultsTableViewController: UISearchBarDelegate {
    
  
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        // If search bar empty show nothing
        if searchTerm.isEmpty {
            DispatchQueue.main.async {
                self.searchResultsController.searchResults.removeAll()
                self.tableView.reloadData()
            }
        }
        switch segment.selectedSegmentIndex {
        case 0:
            resultType = .software


        case 1:
            resultType = .musicTrack


        case 2 :
            resultType = .movie

        default:
            break
        }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
              DispatchQueue.main.async {
                self.tableView.reloadData()
                  }
        }
      
    }
}
