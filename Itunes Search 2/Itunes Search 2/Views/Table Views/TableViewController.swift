//
//  TableViewController.swift
//  Itunes Search 2
//
//  Created by Michael Flowers on 1/29/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Properties
    let searchResultController = SearchResultController()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: - SearchBar Delegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("button tapped")
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType!
        
        switch segmentControl.selectedSegmentIndex{
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        searchResultController.performSearch(with: searchTerm, a: resultType) { (error) in //someone will have to explain to me exactly how this result type works
            if let error = error {
                NSLog("Error making the network call: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let result = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        
        // Configure the cell...
        return cell
    }
}
