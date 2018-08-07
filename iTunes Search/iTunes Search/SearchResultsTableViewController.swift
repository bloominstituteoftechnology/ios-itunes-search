//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Jeremy Taylor on 8/7/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        
    }
    @IBAction func segmentedControlChanged(_ sender: Any) {
        updateSearch()
    }
    func updateSearch() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType!
        
        switch categorySegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        
        guard let category = resultType else { return }
        
        searchResultsController.performSearch(with: searchTerm, resultType: category, numberOfResults: "10") { (searchResults, error) in
            self.searchResult = searchResults ?? []
            NSLog("Category: \(category)")
        }
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)

        // Configure the cell...
        
        let result = searchResult[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateSearch()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    let searchResultsController = SearchResultsController()
    var searchResult = [SearchResult]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
