//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Ilgar Ilyasov on 9/18/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Storyboard outlets
    
    @IBOutlet weak var appMusicMovie: UISegmentedControl!
    @IBOutlet weak var itunesSearchBar: UISearchBar!
    
    // MARK: - Properties
    
    let searchResultController = SearchResultController()
    var resultType: ResultType!
    
    // MARK: - App lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itunesSearchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let searchResult = searchResultController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
    
    // MARK: - Search bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Make sure there is a search term
        guard let searchTerm = itunesSearchBar.text, !searchTerm.isEmpty else { return }
        
        // Assign a resultType to the related segments
        switch appMusicMovie.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        // Perform the search
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) {(error) in
            DispatchQueue.main.async {
                
                // If there is an error, log it
                if let error = error{
                    NSLog("Search error: \(error)")
                } else {
                    
                    // If not, then reload tableviews data
                    self.tableView.reloadData()
                    self.view.endEditing(true) // Stop edit option of the search bar after return clicked
                }
            }
        }
    }
}
