//
//  SearchResultsTableViewController.swift
//  Itunes Search
//
//  Created by Iyin Raphael on 9/18/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
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
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    

}
