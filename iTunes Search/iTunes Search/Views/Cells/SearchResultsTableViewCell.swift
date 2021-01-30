//
//  SearchResultsTableViewCell.swift
//  iTunes Search
//
//  Created by James McDougall on 1/29/21.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        artistLabel.text = searchResult?.creator
        trackNameLabel.text = searchResult?.title
    }

}
