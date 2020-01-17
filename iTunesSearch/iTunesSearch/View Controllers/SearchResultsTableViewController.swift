//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by David Wright on 1/17/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: - Properties

    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var mediaTypeSelector: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Action Handlers

    @IBAction func mediaTypeSelectorChanged(_ sender: UISegmentedControl) {
        updateDataSource()
    }
    
    // MARK: - Private Methods
    
    private func resultTypeFor(selectedSegmentIndex: Int) -> ResultType {
        switch selectedSegmentIndex {
        case 0:
            return .software
        case 1:
            return .musicTrack
        default:
            return .movie
        }
    }
    
    private func updateDataSource() {
        guard let searchTerm = searchBar.text,
            let selectedSegmentIndex = mediaTypeSelector?.selectedSegmentIndex else { return }
        
        let resultType = resultTypeFor(selectedSegmentIndex: selectedSegmentIndex)
        
        print("Searching for \(searchTerm)...")
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType, completion: { (error) in
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                print("Found \(self.searchResultsController.searchResults.count) results!")
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultTableViewCell
        
        guard indexPath.row < searchResultsController.searchResults.count else { return cell }
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.searchResult = searchResult
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateDataSource()
    }
}
