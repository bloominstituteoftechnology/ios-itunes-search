//
//  SearchResultTableViewCell.swift
//  iTunesSearch
//
//  Created by Josh Kocsis on 5/7/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchCell"
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    
    private func updateViews() {
        guard let search = searchResult else { return }
        
        titleLabel.text = search.title
        creatorLabel.text = search.creator
    }
    
}
