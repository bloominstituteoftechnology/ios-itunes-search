//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Nichole Davidson on 4/6/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let searchResultController = SearchResultController()
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.dataSource = dataSource

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
           guard let searchTerm = searchBar.text,
               searchTerm != "" else { return }
        
        searchBar.resignFirstResponder()
        searchWith(searchTerm: searchTerm)
       
           var resultType: ResultType!
           
           switch segmentedControl.selectedSegmentIndex {
           case 0:
               resultType = .software
           case 1:
               resultType = .musicTrack
           case 2:
               resultType = .movie
           default:
               break
           }
           
        searchResultController.performSearch(for: searchTerm, resultType: resultType) {
            self.activityIndicator.startAnimating()
               DispatchQueue.main.async {
                   self.update()
               }
           }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                searchResultController.searchResults = []
                update()
                return
            }
            
            searchWith(searchTerm: searchText)
        }
       }

//    // MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchResultsController.searchResults.count
//
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
//
//        let searchResult = searchResultsController.searchResults[indexPath.row]
//
//        cell.textLabel?.text = searchResult.title
//        cell.detailTextLabel?.text = searchResult.creator
//
//        return cell
//    }

}

// MARK: -UITableViewDiffableDataSource

extension SearchResultsTableViewController {
    enum Section {
        case main
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, SearchResult> {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, searchResult in
            let cell = tableView
                .dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier,
                                for: indexPath) as! SearchResultTableViewCell
            
            cell.searchResult = searchResult
            return cell
            
        }
    }
    
    private func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SearchResult>() // <Section, SearchResult> is called Generics (look up)
        snapshot.appendSections([.main])
        snapshot.appendItems(searchResultController.searchResults)
        dataSource.apply(snapshot, animatingDifferences: true)
        activityIndicator.stopAnimating()
    }
    
}




extension SearchResultsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchBar.resignFirstResponder()
        let searchResult = searchResultController.searchResults[indexPath.row]
        dump(searchResult)
    }
}
