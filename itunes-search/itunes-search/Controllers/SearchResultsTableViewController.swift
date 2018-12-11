//
//  SearchResultsTableViewController.swift
//  itunes-search
//
//  Created by Austin Cole on 12/11/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultsController = SearchResultController()
    let searchResultsCell = SearchResultsCellController()
    

    
    
    
    
    @IBOutlet weak var iTunesSearchBar: UISearchBar!
    @IBOutlet weak var mediaTypeControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        iTunesSearchBar.delegate = self
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var resultType: ResultType!
        guard let text = iTunesSearchBar.text else {return}
        switch mediaTypeControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 3:
            resultType = .movie
        default:
            resultType = .software
        }
        searchResultsController.performSearch(searchTerm: text, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
                return
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print(searchResultsController.searchResults[indexPath.row])
        cell.textLabel?.text = searchResultsController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultsController.searchResults[indexPath.row].creator

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
