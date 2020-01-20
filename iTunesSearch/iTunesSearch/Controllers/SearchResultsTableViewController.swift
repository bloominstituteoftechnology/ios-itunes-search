//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by alfredo on 1/19/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: - IBOutets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControlBar: UISegmentedControl!
    
    //MARK: - Properties
    
    let searchResultsController: SearchResultController = SearchResultController()
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultTableViewCell
        let index = indexPath.row
        let searchResult = searchResultsController.searchResults[index]
        
        cell.titleLabel?.text = searchResult.title
        cell.subtitleLabel?.text = searchResult.creator

        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        let selectedSegmentIndex = segmentedControlBar.selectedSegmentIndex
        var resultType: ResultType!
        
        switch true{
        case selectedSegmentIndex == 0:
            resultType = .software
        case selectedSegmentIndex == 1:
            resultType = .musicTrack
        case selectedSegmentIndex == 2:
            resultType = .movie
        default:
            break
        }
        
        searchResultsController.performSearch(searchTerm: searchBarText, resultType: resultType){_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
