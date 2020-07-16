//
//  SearchResultsTableViewController.swift
//  ITunesSearch
//
//  Created by Nick Nguyen on 2/11/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit
import SafariServices

class SearchResultsTableViewController: UITableViewController {
  
  private let searchResultsController = SearchResultController()
  //MARK:- Properties
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var segment: UISegmentedControl!
  
  
  @IBAction func segmentChanged(_ sender: UISegmentedControl) {
    searchResultsController.searchResults.removeAll()
    tableView.reloadData()
    searchBar.text = ""
  }
  
  
  //MARK: - App Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
  }
  
  // MARK: - Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResultsController.searchResults.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "iCell", for: indexPath)
    cell.textLabel?.text = searchResultsController.searchResults[indexPath.row].title
    cell.detailTextLabel?.text = searchResultsController.searchResults[indexPath.row].creator
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let index = tableView.indexPathForSelectedRow {
      let url = URL(string: searchResultsController.searchResults[index.row].artistViewUrl!)
      let safariVC = SFSafariViewController(url: url!)
      present(safariVC, animated: true, completion: nil)
 
    }
    
  }
}

//MARK: - SearchBar Delegate
extension SearchResultsTableViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText == "" {
      searchResultsController.searchResults.removeAll()
      tableView.reloadData()
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text else { return }
    var resultType: ResultType!
    
    // If search bar empty show nothing
    if searchTerm.isEmpty {
      DispatchQueue.main.async {
        self.searchResultsController.searchResults.removeAll()
        self.tableView.reloadData()
      }
    }
    switch segment.selectedSegmentIndex {
      case 0:
        resultType = .software
      case 1:
        resultType = .musicTrack
      case 2 :
        resultType = .movie
      default:
        break
    }
    searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      DispatchQueue.main.async {
        
        self.tableView.reloadData()
        
      }
    }
  }
}
