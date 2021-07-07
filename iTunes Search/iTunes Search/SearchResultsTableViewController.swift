//
//  ViewController.swift
//  iTunes Search
//
//  Created by Simon Elhoej Steinmejer on 07/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource, SearchResultHeaderViewDelegate
{
    let cellId = "resultCell"
    let headerId = "searchHeader"
    let searchResultController = SearchResultController()
    let searchLimits = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    var searchLimit = 10
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "iTunes Search"
        tableView.register(DetailCell.self, forCellReuseIdentifier: cellId)
        tableView.register(SearchResultHeaderView.self, forHeaderFooterViewReuseIdentifier: headerId)
    }
    
    //MARK: SearchBar & SegmentedControl Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        handleSearch(searchBar: searchBar)
    }
    
    func segmentedControlValueChanged(searchBar: UISearchBar)
    {
        handleSearch(searchBar: searchBar)
    }
    
    private func handleSearch(searchBar: UISearchBar)
    {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        var searchType: ResultType
        
        let headerView = tableView.headerView(forSection: 0) as! SearchResultHeaderView
        
        switch headerView.mediaTypeSegmentedControl.selectedSegmentIndex
        {
        case 0:
            searchType = .software
        case 1:
            searchType = .musicTrack
        case 2:
            searchType = .movie
        default:
            return
        }
        
        headerView.searchBar.resignFirstResponder()
        
        searchResultController.performSeach(with: searchTerm, resultType: searchType, searchLimit: searchLimit) { (error) in
            
            if let error = error
            {
                NSLog("An error occured while searching for \(searchTerm): \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - PickerView Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return searchLimits.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return String(searchLimits[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        searchLimit = searchLimits[row]
        
        let headerView = tableView.headerView(forSection: 0) as! SearchResultHeaderView
        
        handleSearch(searchBar: headerView.searchBar)
    }

    //MARK: - TableView DataSource and Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResultController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DetailCell
        
        let searchResult = searchResultController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! SearchResultHeaderView
        
        headerView.searchBar.delegate = self
        headerView.delegate = self
        headerView.searchLimitPickerView.delegate = self
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 180
    }
}












