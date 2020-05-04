//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Enzo Jimenez-Soto on 5/4/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var iTunesSearchBar: UISearchBar!
    
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iTunesSearchBar.delegate = self
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        let index = segmentedControl.selectedSegmentIndex
        
        helperSearchFunc(searchTerm: searchTerm, index: index)
    }
    
    @IBAction func changeType(_ sender: Any) {
        guard let searchTerm = iTunesSearchBar.text else {return}
        let index = segmentedControl.selectedSegmentIndex
        helperSearchFunc(searchTerm: searchTerm, index: index)
    }
    
    
    private func helperSearchFunc(searchTerm: String, index:Int){
        
        var resultType:ResultType?
        switch index {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        
        guard let type = resultType else {return}
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: type) { (error) -> Void in
            if let error = error{
                NSLog("Error performing search: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let result = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        
        cell.detailTextLabel?.text = result.creator
        
        // Configure the cell...
        
        return cell
    }
    
}


