//
//  ViewController.swift
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

	@IBOutlet var searchBar: UISearchBar!

	let searchResultController = SearchResultController()
	let mahDataGetter = MahDataGetter()

	func requestSearch(with searchTerm: String?, mediaType: ResultType) {
		guard let searchTerm = searchTerm, !searchTerm.isEmpty else { return }
		searchResultController.performSearch(with: searchTerm, resultType: mediaType) { (error) in
			DispatchQueue.main.async { [weak self] in
				if let error = error {
					let alertController = UIAlertController(title: "ERROR",
															message: "There was an error: \(error)",
															preferredStyle: .alert)
					alertController.addAction(UIAlertAction(title: "Okay", style: .cancel))
					self?.present(alertController, animated: true)
					return
				}

				self?.tableView.reloadData()

			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResultController.searchResults.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
		guard let searchCell = cell as? SearchTableViewCell else { return cell }
		let result = searchResultController.searchResults[indexPath.row]
		searchCell.dataGetter = mahDataGetter
		searchCell.searchResult = result

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let resultType = ResultType.resultTypeFromIndex(searchBar.selectedScopeButtonIndex)
		guard let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell,
			let result = cell.searchResult else { return }
		if resultType == .music {
			searchResultController.fetchAndPlayPreview(for: result)
		}
	}
}

extension SearchResultsTableViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let resultType = ResultType.resultTypeFromIndex(searchBar.selectedScopeButtonIndex)
		requestSearch(with: searchBar.text, mediaType: resultType)
		searchBar.resignFirstResponder()
	}

	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		let resultType = ResultType.resultTypeFromIndex(selectedScope)
		requestSearch(with: searchBar.text, mediaType: resultType)
	}
}
