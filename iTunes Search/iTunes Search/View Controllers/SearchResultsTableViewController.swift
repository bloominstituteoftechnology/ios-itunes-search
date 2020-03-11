//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Mark Gerrior on 3/10/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryPicker: UIPickerView!
    
    // MARK: - Actions

    @IBAction func segmentControlPressed(_ sender: Any) {
        performSearch()
    }
    
    // MARK: - Proprerties
    private let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        countryPicker.delegate = self
        countryPicker.dataSource = self
    }

    func performSearch() {
        guard let searchTerm = searchBar.text,
              let index = typeSegmentControl?.selectedSegmentIndex
        else { return }

        // Clear the existing results first.
        searchResultsController.clearResults()
        tableView.reloadData()
        
        let countryIndex = countryPicker.selectedRow(inComponent: 0)
        let twoLetterCountryCode = countries[countryIndex * 2]

        var resultType: ResultType
        
        switch index {
        case 0:
            resultType = .software
        case 1:
            resultType = .music
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm,
                                              resultType: resultType,
                                              twoLetterCountryCode: twoLetterCountryCode) { error in
            if let error = error {
                NSLog("Search failed \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath)

        // Configure the cell...
        let title = searchResultsController.searchResults[indexPath.row].title ?? "< Missing Title >"
        let creator = searchResultsController.searchResults[indexPath.row].creator ?? "< Missing Creator >"
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = creator
        
        return cell
    }
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
}

let countries = ["US", "United States of America",
                 "AU", "Australia",
                 "BR", "Brazil",
                 "CA", "Canada",
                 "FR", "France",
                 "JP", "Japan",
                 "MX", "Mexico",
                 "PT", "Portugal",
                 "SA", "Saudi Arabia",
                 "ES", "Spain",
                 "XX", "Bogus - Will Fail",
]

extension SearchResultsTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("row: \(row)")
        if row >= (countries.count / 2) {
            return ""
        }
        return countries[row * 2 + 1]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // TODO: What doesn't this have an Action?
        performSearch()
    }
}
