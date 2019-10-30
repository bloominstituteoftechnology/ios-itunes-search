//
//  ItemTableViewCell.swift
//  ItunesSearch
//
//  Created by brian vilchez on 10/30/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    var artist: Artist? {
        didSet {
            updateViews()
        }
    }
    
    
    private func updateViews() {
        guard let artist = artist else { return }
        nameLabel.text = artist.artistName
        creatorLabel.text = artist.trackName
    }
    
    
}
