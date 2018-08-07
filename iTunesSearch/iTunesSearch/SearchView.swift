//
//  SearchView.swift
//  iTunesSearch
//
//  Created by William Bundy on 8/7/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import Foundation
import UIKit

class ResultCell: UITableViewCell
{
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	var result:SearchResult! {
		didSet {
			nameLabel.text = result.title
			authorLabel.text = result.creator
		}
	}
}

class SearchTVC: UITableViewController, UISearchBarDelegate

{
	var controller:SearchController = SearchController()
	@IBOutlet weak var searchSelector: UISegmentedControl!
	@IBOutlet weak var searchBar: UISearchBar!

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
	{
		controller.results.removeAll()
		controller.results.append(SearchController.loading)
		tableView.reloadData()
		controller.search(searchBar.text!, type: ResultType.all[searchSelector.selectedSegmentIndex]) {
			error in
			if let error = error {
				NSLog("\(error)")
				return
			}

			if self.controller.results.count == 0 {
				self.controller.results.append(SearchController.noResults)
			}
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		searchBar.resignFirstResponder()
	}

	@IBAction func searchTypeChanged(_ sender: Any)
	{
		searchBarSearchButtonClicked(searchBar)
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return controller.results.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let defaultCell =  tableView.dequeueReusableCell(withIdentifier: "ResultCell")
		guard let cell = defaultCell as? ResultCell else {return defaultCell!}
		cell.result = controller.results[indexPath.row]
		return cell
	}

}
