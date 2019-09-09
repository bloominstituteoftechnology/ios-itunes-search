//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Jessie Ann Griffin on 9/8/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: IBOutlets
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        let result = searchResultsController.searchResults[indexPath.row]
        cell.detailTextLabel?.text = result.creator
        cell.textLabel?.text = result.title
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func resetSearchByType(_ sender: Any) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        switch typeSelector.selectedSegmentIndex {
        case 1: // for Music
            resultType = .musicTrack
        case 2: // for Movies
            resultType = .movie
        default: // for Apps
            resultType = .software
        }
        searchResultsController.performSearch(with: searchTerm, type: resultType) { (error) in
            if error != nil {
                print("Error performing search: \(String(describing: error))")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType!
        
        switch typeSelector.selectedSegmentIndex {
        case 1: // for Music
            resultType = .musicTrack
        case 2: // for Movies
            resultType = .movie
        default: // for Apps
            resultType = .software
        }
        
        searchResultsController.performSearch(with: searchTerm, type: resultType) { (error) in
            if error != nil {
                print("Error performing search: \(String(describing: error))")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
