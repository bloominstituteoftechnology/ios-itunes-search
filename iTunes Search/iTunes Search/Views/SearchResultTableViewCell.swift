//
//  SearchResultTableViewCell.swift
//  iTunes Search
//
//  Created by Aaron Cleveland on 1/15/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var results: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let result = results else { return }
        
        titleLabel.text = result.title
        subtitleLabel.text = result.creator
    }
}
