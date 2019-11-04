//
//  ResultsTableViewCell.swift
//  iOSItunesSearch
//
//  Created by denis cedeno on 11/3/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var result: SearchResult? {
        didSet{
            
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let result = result else { return }
    
        titleLabel.text = result.title
        subtitleLabel.text = result.creator
    }
}
