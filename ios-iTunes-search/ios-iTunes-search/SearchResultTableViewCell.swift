//
//  SearchResultTableViewCell.swift
//  ios-iTunes-search
//
//  Created by Lambda_School_Loaner_268 on 2/11/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    //MARK: - Methods
    func updateViews() {
        titleLabel.text = "title"
        artistLabel.text = "creator"
    }

}
