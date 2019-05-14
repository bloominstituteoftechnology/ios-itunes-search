//
//  SearchResultsTableViewController.swift
//  ITunesSearch
//
//  Created by Taylor Lyles on 5/14/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
	
	let searchResultsController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		searchBar.delegate = self
	}

	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ResultsTableViewCell else { return UITableViewCell() }
		
		let result = searchResultsController.searchResults[indexPath.row]
		
		cell.results = result
		
		return cell
	}

	
	@IBOutlet weak var segmentControl: UISegmentedControl!
	@IBOutlet weak var searchBar: UISearchBar!
	

}
