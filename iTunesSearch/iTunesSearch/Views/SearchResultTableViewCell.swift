//
//  SearchResultTableViewCell.swift
//  iTunesSearch
//
//  Created by David Wright on 1/17/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    // MARK: - Properties

    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    
    
    // MARK: - Private Methods
    
    private func updateViews() {
        guard let searchResult = searchResult else { return }
        
        titleLabel.text = searchResult.title
        creatorLabel.text = searchResult.creator
    }
}
