//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Carolyn Lea on 8/7/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate
{
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    let searchResultController = SearchResultController()
    var resultType: ResultType!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        checkForSelectedIndex()
        loadSearch()
    }
    
    func checkForSelectedIndex()
    {
        if segmentedControl.selectedSegmentIndex == 0
        {
            resultType = .software
        }
        else if segmentedControl.selectedSegmentIndex == 1
        {
            resultType = .musicTrack
        }
        else if segmentedControl.selectedSegmentIndex == 2
        {
            resultType = .movie
        }
    }
    
    func loadSearch()
    {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        searchResultController.performSearch(with: searchTerm, resultType: resultType) {  (items, error) in
            self.searchResultController.searchResults = self.searchResultController.searchResults
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func reloadSearch(_ sender: Any)
    {
        checkForSelectedIndex()
        loadSearch()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)

        let result = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    
    
    

}
