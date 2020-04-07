//
//  SearchResultTableViewCell.swift
//  iTunesSearch
//
//  Created by Nichole Davidson on 4/6/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: SearchResultTableViewCell.self)

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
