//
//  SearchResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Thomas Cacciatore on 5/14/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    private func updateViews() {
        guard let result = result else { return }
        
        titleLabel.text = result.title
        creatorLabel.text = result.creator
        
    }
    
    
    
    
    
    var result: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    
}
