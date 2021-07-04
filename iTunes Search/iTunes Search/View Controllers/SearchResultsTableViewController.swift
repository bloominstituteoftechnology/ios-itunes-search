//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Madison Waters on 12/4/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    //var resultType: ResultType?
    //let model: Model? = nil
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    var searchLimitCounter = 0
    
    var resultType: ResultType? {
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
    var searchResultsController = SearchResultsController() {
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
    @IBOutlet weak var searchTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func segmentControlTapped(_ sender: Any) {
        guard let searchTerm = sender as? String else { return }
        updateViews(searchTerm)
    }
    
    @IBAction func searchLimitStepper(_ sender: Any) {
            searchLimitCounter += 1
            //String(searchLimitCounter)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        self.updateHandler = { self.tableView.reloadData() }
    }
    
    deinit {
        updateHandler = nil
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
        //return model?.numberOfResults() ?? 0
        
    }

    let reuseIdentifier = "SearchItemCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        //let searchResult = model?.getSearchResult(at: indexPath.row)
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.artist

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }

        switch self.searchTypeSegmentControl.selectedSegmentIndex {
        case 0:
            resultType = ResultType.software
        case 1:
            resultType = ResultType.musicTrack
        case 2:
            resultType = ResultType.movie
        default:
            break
        }
        
        //Model.shared.searchItunes(for: searchTerm)
        updateViews(searchTerm)

    }
    
    func updateViews(_ searchTerm: String?) {
        guard let resultType = resultType,
            let searchTerm = searchTerm else { return }
            updateHandler?()
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType, String(searchLimitCounter)) { (_,_) in
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
}
