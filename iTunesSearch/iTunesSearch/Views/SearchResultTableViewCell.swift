//
//  SearchResultTableViewCell.swift
//  iTunesSearch
//
//  Created by Christopher Aronson on 5/7/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func updateViews() {
        guard let searchResult = searchResult else { return }
        
        titleLabel.text = searchResult.creator
        subtitleLabel.text = searchResult.title
    }

}
