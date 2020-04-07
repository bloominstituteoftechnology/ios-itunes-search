//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Cameron Collins on 4/6/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    //Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsController.delegate = self
        searchBar.delegate = self
    }
    
    //Variables
    let searchResultsController = SearchResultsController()

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        guard let myCell = cell as? ResultsTableViewCell else {
            return cell
        }
        
        myCell.titleLabel.text = searchResultsController.searchResults[indexPath.row].artistName
        myCell.subtitleLabel.text = searchResultsController.searchResults[indexPath.row].trackName
        
        return myCell
    }
    
    //Search Button Clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchResultsController.performSearch(searchTerm: text, resultType: .musicTrack) {
            DispatchQueue.main.async {
                self.updateTableView()
            }
        }
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



extension SearchResultsTableViewController: SearchResultsDelegate {
    func updateTableView() {
        tableView.reloadData()
    }
    
}
