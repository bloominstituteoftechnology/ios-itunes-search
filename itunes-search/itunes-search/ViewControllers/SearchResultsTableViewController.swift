//
//  SearchResultsTableViewController.swift
//  itunes-search
//
//  Created by Hector Steven on 5/7/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

	@IBOutlet var searchBar: UISearchBar!
	@IBOutlet var segmentedControl: UISegmentedControl!
	let controller = SearchResultController()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self
    }
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchTerm = searchBar.text else { return }
		
		print(searchTerm)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return controller.searchResults.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
		
		return cell
	}
	
}
