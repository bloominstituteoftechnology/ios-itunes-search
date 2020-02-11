//
//  ResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Chris Gonzales on 2/11/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var result: SearchResult?{
        didSet{
            updateViews()
        }
    }

    private func updateViews(){
        guard let result = result else { return }
        titleLabel.text = result.title
        subtitleLabel.text = result.creator        
    }
    
    
}
