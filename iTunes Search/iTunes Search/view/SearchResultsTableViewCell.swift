//
//  SearchResultsTableViewCell.swift
//  iTunes Search
//
//  Created by Vincent Hoang on 5/4/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var creatorLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if let result = searchResult {
            titleLabel.text = result.title
            creatorLabel.text = result.creator
        }
    }
}
