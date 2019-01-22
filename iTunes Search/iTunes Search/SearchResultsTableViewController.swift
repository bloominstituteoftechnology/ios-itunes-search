//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Nathanael Youngren on 1/22/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)


        return cell
    }
    
    @IBOutlet weak var categorySelector: UISegmentedControl!
    @IBOutlet weak var searchField: UISearchBar!
    

}
