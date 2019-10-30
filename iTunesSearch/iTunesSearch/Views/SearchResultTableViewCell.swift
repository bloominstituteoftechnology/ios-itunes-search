//
//  SearchResultTableViewCell.swift
//  iTunesSearch
//
//  Created by Niranjan Kumar on 10/29/19.
//  Copyright © 2019 Nar LLC. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!

    var result: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    
    private func updateViews() {
        guard let result = result else { return }
        
        titleLabel.text = result.title
        creatorLabel.text = result.creator
    }
    
    
}
