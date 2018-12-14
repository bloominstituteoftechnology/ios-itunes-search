//
//  SearchTableViewCell.swift
//  iTunes Search
//
//  Created by Sameera Leola on 12/11/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let reuseIdentifier =  "iTunesDataCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var serchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let searchResult = serchResult else { return }
        
        titleLabel.text = searchResult.title
        detailLabel.text = searchResult.creator
    }
    

    
} //End of class
