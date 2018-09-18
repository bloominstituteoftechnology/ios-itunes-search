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
        guard let searchTerm = itunesSearchBar.text, !searchTerm.isEmpty else { return }
        
        if appMusicMovie.selectedSegmentIndex == 0 {
            
            resultType = ResultType.software
            
            searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { (result, error) in
                if let error = error {
                    NSLog("Error getting search results for \(searchTerm): \(error)")
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } else if appMusicMovie.selectedSegmentIndex == 1 {
            
            resultType = ResultType.musicTrack
            
            searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { (result, error) in
                if let error = error {
                    NSLog("Error getting search results for \(searchTerm): \(error)")
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        } else if appMusicMovie.selectedSegmentIndex == 2 {
            
            resultType = ResultType.movie
            
            searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { (result, error) in
                if let error = error {
                    NSLog("Error getting search results for \(searchTerm): \(error)")
                }
            }
        }
    }
}
