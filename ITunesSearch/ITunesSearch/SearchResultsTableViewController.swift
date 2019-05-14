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
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		guard let searchTerm = searchBar.text else { return }
		var resultType: ResultType!
		
		switch segmentControl.selectedSegmentIndex {
		case 0:
			resultType = .software
		case 1:
			resultType = .musicTrack
		case 2:
			resultType = .movie
		default:
			NSLog("Not valid option")
		}
		
		searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
			if let error = error {
				NSLog("Error exicuting search: \(error)")
				return
			}
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		
		
		
	}

	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
			as? ResultsTableViewCell else { return UITableViewCell() }
		
		let result = searchResultsController.searchResults[indexPath.row]
		
		cell.results = result
		
		return cell
	}

	
	@IBOutlet weak var segmentControl: UISegmentedControl!
	@IBOutlet weak var searchBar: UISearchBar!
	

}
