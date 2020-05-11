//
//  ResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Aaron Peterson on 5/10/20.
//  Copyright © 2020 Aaron Peterson. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ResultCell"

    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultCreator: UILabel!
    
    var result: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let result = result else {
            return
        }
        
        resultTitle.text = result.title
        resultCreator.text = result.creator
    }

}
