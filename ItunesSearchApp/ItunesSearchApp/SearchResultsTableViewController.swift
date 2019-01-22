//
//  SearchResultsTableViewController.swift
//  ItunesSearchApp
//
//  Created by Nelson Gonzalez on 1/22/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var chooseSegmentedControl: UISegmentedControl!
    
    let searchResultsController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      updateViews()
    }
    
    private func updateViews(){
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        var resultType: ResultType!
        let index = chooseSegmentedControl.selectedSegmentIndex
        
        if index == 0 {
            resultType = .software
        } else if index == 1 {
            resultType = .musicTrack
            
        } else if index == 2 {
            resultType = .movie
            
        }
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (error) in
            if error != nil {
                NSLog("There is an error retreiving search \(error!.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)

        let results = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = results.title
        cell.detailTextLabel?.text = results.creator

        return cell
    }
    
    @IBAction func segmentedControllPressed(_ sender: UISegmentedControl) {
        updateViews()
    }
    

}
