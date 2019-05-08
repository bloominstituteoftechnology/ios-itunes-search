//
//  SearchResultsTableViewController.swift
//  itunes-search
//
//  Created by Hector Steven on 5/7/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
	
	override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self
    }
	
	@IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
		makeSearch(currentSearchTerm)
	}
	
	private func makeSearch(_ searchTerm: String) {
		let selectedSegment = segmentedControl.selectedSegmentIndex
		var resultType: ResultType
		
		if selectedSegment == 0 {
			resultType = .software
		} else if selectedSegment == 1 {
			resultType = .musicTrack
		} else {
			resultType = .movie
		}
	
		controller.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
			
			DispatchQueue.main.async {
				if let error = error {
					print("error \(error)")
					return
				}
				self.tableView.reloadData()
			}
		}
	}
	
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchTerm = searchBar.text else { return }
		currentSearchTerm = searchTerm
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return controller.searchResults.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
		let result = controller.searchResults[indexPath.row]
		cell.textLabel?.text = result.title
		cell.detailTextLabel?.text = result.creator
		return cell
	}
	@IBOutlet var searchBar: UISearchBar!
	@IBOutlet var segmentedControl: UISegmentedControl!
	let controller = SearchResultController()
	
	var currentSearchTerm : String = "" {
		didSet {
			makeSearch(currentSearchTerm)
		}
	}
	
}
