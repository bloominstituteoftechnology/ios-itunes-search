//
//  PersonTableViewCell.swift
//  iTunesList
//
//  Created by Austin Potts on 9/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    
    
    var searchResult: SearchResult? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let searchResult = searchResult else {return}
        
        nameLabel.text = searchResult.creator
        trackLabel.text = searchResult.title
        
    }

}
