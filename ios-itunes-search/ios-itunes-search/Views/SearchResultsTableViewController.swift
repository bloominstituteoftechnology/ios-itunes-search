//
//  SearchResultsTableViewController.swift
//  ios-itunes-search
//
//  Created by Casualty on 9/8/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultController = SearchResultController()
    
    private var resultType: ResultType {
        let segment = resultTypeSegmentedControl.selectedSegmentIndex
        if segment == 0 {
            return .software
        } else if segment == 1 {
            return .musicTrack
        } else {
            return .movie
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    @IBAction func changeResultType(_ sender: Any) {
        performSearch()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let searchResult = searchResultController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        if let imageData = searchResult.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearch()
    }
    
    private func performSearch() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                print("Error searching \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

            for result in self.searchResultController.searchResults {
                self.searchResultController.loadImage(result, completion: { (error) in
                    if let error = error {
                        print("Error getting image \(error)")
                        return
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
}
