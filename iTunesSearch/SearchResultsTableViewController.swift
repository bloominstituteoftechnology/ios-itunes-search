//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Bhawnish Kumar on 3/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResultController = SearchResultController()
    var resultType: [ResultType] = [.software, .musicTrack, .movie]
    private var activityIndicator = UIActivityIndicatorView()
     
    override func viewDidLoad() {
        super.viewDidLoad()
 searchBar.delegate = self
        tableView.backgroundView = activityIndicator
        searchBarSearchButtonClicked(searchBar)
        self.tableView.reloadData()
    }

    @IBAction func segmentedControl(_ sender: Any) {
        
     searchBarSearchButtonClicked(searchBar)
        
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)
        let result = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        // Configure the cell...

        return cell
    }
    

   
}

extension  SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        var resultTypeSelected = resultType[segmentedControl.selectedSegmentIndex]
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultTypeSelected = .software
        case 1:
            resultTypeSelected = .musicTrack
        case 2:
            resultTypeSelected = .movie
        default:
            break
        }
    
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultTypeSelected) { error in
            DispatchQueue.main.async {
                
                self.activityIndicator.stopAnimating()
                if let error = error {
                    NSLog("There is an error fetching \(error)")
                }
                self.tableView.reloadData()
            }
             
        }
        activityIndicator.startAnimating()
      self.tableView.reloadData()
    searchBar.resignFirstResponder()
  }

     
 }
