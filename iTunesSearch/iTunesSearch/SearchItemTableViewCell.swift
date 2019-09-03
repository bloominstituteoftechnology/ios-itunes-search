//
//  SearchItemTableViewCell.swift
//  iTunesSearch
//
//  Created by admin on 9/3/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SearchItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let searchResult = searchResult else { return }
        
        titleLabel.text = searchResult.title
        artistLabel.text = searchResult.creator
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
