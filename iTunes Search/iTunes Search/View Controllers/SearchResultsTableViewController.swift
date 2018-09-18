//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Madison Waters on 9/18/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var resultType : ResultType! {
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    var searchResultsController = SearchResultsController(){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var searchTypeSegementedControl: UISegmentedControl!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBarOutlet?.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItunesSearchCell", for: indexPath)

        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.textLabel?.text = searchResult.artist
    
        return cell
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        if searchTypeSegementedControl.selectedSegmentIndex == 0 {
            resultType = ResultType.software
        } else if searchTypeSegementedControl.selectedSegmentIndex == 1 {
            resultType = ResultType.musicTrack
        } else if searchTypeSegementedControl.selectedSegmentIndex == 2 {
            resultType = ResultType.movie
        }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (_, _) in
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
}
