//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Linh Bouniol on 8/7/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Properties
    
    let searchResultsController = SearchResultController()
    
    // MARK: Outlets
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var countrySegmentedControl: UISegmentedControl!
    @IBOutlet var limitSegmentedControl: UISegmentedControl!
    
    
    @IBAction func searchParametersWereChanged(_ sender: Any) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the searchBar's delegate to the tableVC
        searchBar.delegate = self
    }
    
    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultsTableViewCell
        
        let result = searchResultsController.searchResults[indexPath.row]
        
        cell.nameLabel?.text = result.title
        cell.artistLabel?.text = result.artist
        
        let dateFormatter = DateFormatter()
        // This is the format the JSON data uses. DateFormatter doesn't know what the JSON data's format is so you need to let it know.
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        // Converting the JSON data into the format you just told dateFormatter
        let date = dateFormatter.date(from: result.releaseDate)
        
        if let date = date {
            // This is the format you want the date to look like
            dateFormatter.dateFormat = "MMM d, yyyy"
            // Reconverting the date back into something nicer and assigning it to the cell's label
            cell.releaseDateLabel?.text = dateFormatter.string(from: date)
        } else {
            cell.releaseDateLabel?.text = ""
        }
        
        
        return cell
    }
    
    // MARK: - UISearchBarDelegate
    
    // This method triggers searches when the user taps the search button on the keyboard.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm.count > 0 else { return }
        
        var resultType: ResultType!
        let country: String!
        let numberOfResults: String!
        
        let index = segmentedControl.selectedSegmentIndex
        
        if index == 0 {
            resultType = .software
        } else if index == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        
        let countryIndex = countrySegmentedControl.selectedSegmentIndex
        
        if countryIndex == 0 {
            country = "US"
        } else if countryIndex == 1 {
            country = "CA"
        } else {
            country = "JP"
        }
        
        let limitIndex = limitSegmentedControl.selectedSegmentIndex
        
        if limitIndex == 0 {
            numberOfResults = "10"
        } else if limitIndex == 1 {
            numberOfResults = "50"
        } else {
            numberOfResults = "100"
        }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType, country: country, limit: numberOfResults) { (searchResults, error) in
            if let error = error {
                NSLog("Error loading search results: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
}
