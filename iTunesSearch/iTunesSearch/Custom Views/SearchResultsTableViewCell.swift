//
//  SearchResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Ciara Beitel on 9/3/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var artist: UILabel!
    
    var mediaItemResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let mediaItemResult = mediaItemResult else { return }
        title.text = mediaItemResult.title
        artist.text = mediaItemResult.creator
    }
}
