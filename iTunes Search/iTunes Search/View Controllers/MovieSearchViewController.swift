//
//  MovieSearchViewController.swift
//  iTunes Search
//
//  Created by Eoin Lavery on 08/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieSegue" {
            guard let selectedIndexPath = tableView.indexPathForSelectedRow,
                let detailVC = segue.destination as? SearchDetailViewController else { return }
                    detailVC.result = searchResultsController.searchResults[selectedIndexPath.row]
        }
    }
    
}

// MARK: - UITableViewDelegate Section
extension MovieSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK: - UITableViewDataSource Section
extension MovieSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        
        let result = searchResultsController.searchResults[indexPath.row]
        cell.searchResult = result
        
        return cell
    }

}

// MARK: - UISearchBarDelegate Section
extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        initiateSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        initiateSearch()
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        initiateSearch()
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let firstSubview = searchBar.subviews.first else { return }
        
        firstSubview.subviews.forEach {
            ($0 as? UITextField)?.clearButtonMode = .never
        }
    }
    
    func initiateSearch() {
        
        guard let searchText = searchBar.text else { return }
        
        searchResultsController.performSearch(searchTerm: searchText, resultType: .movie) { error in
            if let error = error {
                print("Unable to fetch data: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
