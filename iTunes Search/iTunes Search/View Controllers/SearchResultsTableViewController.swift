//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Eoin Lavery on 06/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchTypeTabBar: UITabBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let searchResultsController = SearchResultController()
    var selectedTabBarItemIndex = 0
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
        searchTypeTabBar.delegate = self
        searchBar.showsCancelButton = true
        searchTypeTabBar.selectedItem = searchTypeTabBar.items?[0]
        title = "Apps"
    }
    
    // MARK: - Functions
    @objc func searchTypeValueChanged() {
        searchResultsController.searchResults = []
        tableView.reloadData()
        initiateSearch()
    }
    
    func tabBarItemChanged(tabBar: UITabBar, item: UITabBarItem) {
        if item == tabBar.items?[0] {
            selectedTabBarItemIndex = 0
            title = "Apps"
        } else if item == tabBar.items?[1] {
            selectedTabBarItemIndex = 1
            title = "Music"
        } else if item == tabBar.items?[2] {
            selectedTabBarItemIndex = 2
            title = "Movies"
        }
        
        initiateSearch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            guard let selectedIndexPath = tableView.indexPathForSelectedRow,
                let detailVC = segue.destination as? SearchDetailViewController else { return }
                    detailVC.result = searchResultsController.searchResults[selectedIndexPath.row]
        }
    }
}

// MARK: - UITableViewDelegate Section
extension SearchResultsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK: - UITableViewDataSource Section
extension SearchResultsTableViewController: UITableViewDataSource {
    
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
extension SearchResultsTableViewController: UISearchBarDelegate {
    
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
        var resultType: ResultType!
        
        switch selectedTabBarItemIndex{
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            return
        }
        
        searchResultsController.performSearch(searchTerm: searchText, resultType: resultType) { error in
            if let error = error {
                print("Unable to fetch data: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}

// MARK: - UITabBarDelegate Section
extension SearchResultsTableViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBarItemChanged(tabBar: tabBar, item: item)
    }
}
