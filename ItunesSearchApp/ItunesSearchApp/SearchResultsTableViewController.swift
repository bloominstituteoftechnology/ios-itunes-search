//
//  SearchResultsTableViewController.swift
//  ItunesSearchApp
//
//  Created by Nelson Gonzalez on 1/22/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var chooseSegmentedControl: UISegmentedControl!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    


}
