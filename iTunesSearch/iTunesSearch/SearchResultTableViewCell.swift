//
//  SearchResultTableViewCell.swift
//  iTunesSearch
//
//  Created by John McCants on 7/9/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    var searchResult : SearchResult? {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let searchResult = searchResult else {return}
        title.text = searchResult.creator
        subtitle.text = searchResult.title
        
    }

}
