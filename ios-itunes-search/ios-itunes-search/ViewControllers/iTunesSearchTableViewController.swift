//
//  iTunesSearchTableViewController.swift
//  ios-itunes-search
//
//  Created by Benjamin Hakes on 12/5/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import UIKit

class iTunesSearchTableViewController: UITableViewController {

    static let reuseIdentifier = "cell"
    @IBOutlet weak var segmentControl: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Search Bar Functionality
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        //Model.shared.search(for: searchTerm)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1 // placeholder for Model.shared.numberOfSearchResults() or equivalent
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: iTunesSearchTableViewController.reuseIdentifier, for: indexPath) as? TableViewCell else {fatalError("Unable to receive and cast cell")}

        // Configure the cell...
        
        // let person = Model.shared.person(at: indexPath.row)
        
        
        // fill out the cell labels
        cell.titleLabel.text = "Title Placeholder"
        cell.creatorLabel.text = "Creator Placeholder"

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
