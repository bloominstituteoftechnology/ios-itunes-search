//
//  SearchTableVC.swift
//  iTunes Search
//
//  Created by Jeffrey Santana on 8/6/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class SearchTableVC: UITableViewController {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var categorySegControl: UISegmentedControl!
	@IBOutlet weak var searchBar: UISearchBar!
	
	//MARK: - Properties
	
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
}
