//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Carolyn Lea on 8/7/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController
{
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    
    
    

}
