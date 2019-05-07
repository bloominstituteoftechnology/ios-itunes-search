//
//  SearchResultsTableViewController.swift
//  iTunesHW
//
//  Created by Michael Flowers on 5/7/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchController = SearchResultController()
    

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let searchResult = searchController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        return cell
    }
    
    //MARK: - UISearchBarDelegate Method
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var resultType: ResultType!
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
            callPerformSearch(searchTerm: searchTerm, resultType: resultType)
        case 1:
            resultType = .musicTrack
             callPerformSearch(searchTerm: searchTerm, resultType: resultType)
        case 2:
            resultType = .movie
             callPerformSearch(searchTerm: searchTerm, resultType: resultType)
        default:
            break
        }
    }
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        var resultType: ResultType!
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
            callPerformSearch(searchTerm: searchTerm, resultType: resultType)
        case 1:
            resultType = .musicTrack
            callPerformSearch(searchTerm: searchTerm, resultType: resultType)
        case 2:
            resultType = .movie
            callPerformSearch(searchTerm: searchTerm, resultType: resultType)
        default:
            break
        }
    }
    
    func callPerformSearch(searchTerm: String, resultType: ResultType){
        
        //now that we've made sure that we have text in the search bar we can call the performsearch function
        //also NOW THAT WE'VE GIVEN THE RESULTTYPE A VALUE BASED ON THE SEGMENTED CONTROL INDEX, WE CAN CALL THE PERFORMSEARCH FUNCTION
        
        searchController.performSearch(with: searchTerm, a: resultType) { (error) in
            if let error = error {
                print("Error insde calling the perform search function: \(error.localizedDescription)")
                return
            }
            //since we don't have the array inside the declaration of the network call, we can just relaod the tableView on the main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
