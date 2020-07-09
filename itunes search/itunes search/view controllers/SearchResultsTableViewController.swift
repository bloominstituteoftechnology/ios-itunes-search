//
//  TableViewController.swift
//  itunes search
//
//  Created by ronald huston jr on 5/4/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    //  MARK: - IBOutlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func segmentChanged(_ sender: Any) {
        searchBarSearchButtonClicked()
    }
    
    //  MARK: -
    
    let searchResultController = SearchResultController()
    var searchResults = [SearchResult]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //  MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let results = searchResults[indexPath.row]
        
        cell.textLabel?.text = results.title
        cell.detailTextLabel?.text = results.creator
        
        return cell
    }

    func searchBarSearchButtonClicked() {
        var resultType: ResultType!
        guard let parameter = searchBar.text  else { return }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        searchResultController.performSearch(searchTerm: parameter, resultType: resultType) { (searchResults, error) -> Void in
            
            if let error = error {
                NSLog("error performing search function you wrote: \(error)")
                return
            }
            self.searchResults = searchResults ?? []
            return
        }
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func updateTableView() {
        tableView.reloadData()
    }
}
