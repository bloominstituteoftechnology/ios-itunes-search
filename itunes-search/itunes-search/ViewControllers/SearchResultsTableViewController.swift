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
		let selectedSegment = segmentedControl.selectedSegmentIndex
		
		
		var resultType: SearchResultController.ResultType = .musicTrack
		if selectedSegment == 0 {
			resultType = .software
		} else if selectedSegment == 1 {
			resultType = .musicTrack
		} else if selectedSegment == 2 {
			resultType = .movie
		} else {
			print("error: segmentedControl.selectedSegmentIndex")
		}
		

		controller.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
			DispatchQueue.main.async {
				guard let error = error else { return }
				print("error \(error)")
				
				
				
				self.tableView.reloadData()
			}
		}
		print(controller.searchResults.count)
		print(searchTerm)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return controller.searchResults.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
//		let result = controller.searchResults[indexPath.row]
//		cell.textLabel?.text = result.title
//		cell.detailTextLabel?.text = result.creator
		return cell
	}
	
}
