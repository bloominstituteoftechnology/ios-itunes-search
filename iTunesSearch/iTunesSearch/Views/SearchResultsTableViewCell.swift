//
//  SearchResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Nichole Davidson on 3/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var creatorLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let searchResult = searchResult else { return }
        
        titleLabel.text = searchResult.title
        creatorLabel.text = searchResult.creator
    }

}
