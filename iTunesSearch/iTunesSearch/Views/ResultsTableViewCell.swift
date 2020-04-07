//
//  ResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Cameron Collins on 4/6/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
