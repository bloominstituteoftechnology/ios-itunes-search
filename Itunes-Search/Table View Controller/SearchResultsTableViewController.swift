//
//  SearchResultsTableViewController.swift
//  Itunes-Search
//
//  Created by Percy Ngan on 9/3/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

	// MARK: - IBOutlets

	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var searchBar: UISearchBar!


	// MARK: - Properties

	private var searchResultsController = SearchResultController()

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		searchBar.delegate = self
	}

	// MARK: - IBActions

	@IBAction func categoryChange(_ sender: Any) {
		searchMode()
	}
		// MARK: - Helpers

		private func searchMode() {
			guard let searchText = searchBar.optionalText else { return }
			var resultType: ResultType {
				switch segmentedControl.selectedSegmentIndex {
				case 0:
					return ResultType.app
				case 1:
					return ResultType.music
				case 2:
					return ResultType.movie
				default:
					return ResultType.all
				}
			}

			searchResultsController.performSearch(forSearch: searchText, ofResult: resultType) { (error) in
				if let _ = error {	} else {
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				}
			}
		}


		// MARK: - Table view data source

		//    override func numberOfSections(in tableView: UITableView) -> Int {
		//        // #warning Incomplete implementation, return the number of sections
		//        return 0
		//    }

		override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			// #warning Incomplete implementation, return the number of rows
			return searchResultsController.searchResults.count
		}


		override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)

			let result = searchResultsController.searchResults[indexPath.row]
			cell.textLabel?.text = result.title
			cell.detailTextLabel?.text = result.creator

			return cell
		}
	}

	extension SearchResultsTableViewController: UISearchBarDelegate {
		func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
			searchMode()
		}
	}

	extension UISearchBar {
		var optionalText: String? {
			let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
			return (trimmedText ?? "").isEmpty ? nil : trimmedText
		}
}
