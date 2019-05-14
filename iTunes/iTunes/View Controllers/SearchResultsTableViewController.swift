//
//  SearchResultsTableViewController.swift
//  iTunes
//
//  Created by Hayden Hastings on 5/14/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 

    @IBOutlet weak var iTunesSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var iTunesSearchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
}
