//
//  iTunesSearchTableViewController.swift
//  ios-itunes-search
//
//  Created by Benjamin Hakes on 12/5/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import UIKit

class iTunesSearchTableViewController: UITableViewController, UISearchBarDelegate {

    static let reuseIdentifier = "cell"
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }

    // MARK: - Search Bar Functionality
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        //Model.shared.search(for: searchTerm)
        var resultType: ResultType!
        
        let segmentIndex = segmentControl.selectedSegmentIndex
        switch segmentIndex {
            case 0:
                resultType = .app
            case 1:
                resultType = .music
            case 2:
                resultType = .movie
            default:
                resultType = .app
        }
        
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (searchResults, error) in
            
            guard error == nil else {
                if let error = error { // this will always succeed
                    NSLog("Error searching data: \(error)")
                    return
                }
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: iTunesSearchTableViewController.reuseIdentifier, for: indexPath) as? TableViewCell else {fatalError("Unable to receive and cast cell")}

        // Configure the cell...
        
        // let person = Model.shared.person(at: indexPath.row)
        
        
        // fill out the cell labels
        cell.titleLabel.text = searchResultsController.searchResults[indexPath.row].title
        cell.creatorLabel.text = searchResultsController.searchResults[indexPath.row].creator

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

}
