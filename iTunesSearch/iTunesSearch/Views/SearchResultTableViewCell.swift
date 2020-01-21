//
//  SearchResultTableViewCell.swift
//  iTunesSearch
//
//  Created by alfredo on 1/19/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    //MARK: - IBOutlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    //MARK: - Properties
    
    //MARK: - Methods
    func updateViews(){
        titleLabel.text = "title"
        subtitleLabel.text = "artist"
    }
    
}
