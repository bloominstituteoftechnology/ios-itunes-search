//
//  CustomTableViewCell.swift
//  iTunesSearch
//
//  Created by Alex Rhodes on 9/3/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            setViews()
        }
    }
    
    func setViews() {
        guard let title = searchResult?.title,
        let artist = searchResult?.creator,
            let country = searchResult?.country else {return}
        
        titleLabel.text = title
        artistLabel.text = artist
        countryLabel.text = country
    }
}
