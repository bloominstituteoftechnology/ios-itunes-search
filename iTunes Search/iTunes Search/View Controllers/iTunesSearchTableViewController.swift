//
//  iTunesSearchTableViewController.swift
//  iTunes Search
//
//  Created by Jason Modisett on 9/11/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class iTunesSearchTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        navigationController?.navigationBar.shouldRemoveShadow(true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { return UIView() }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) { view.endEditing(true) }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

}
