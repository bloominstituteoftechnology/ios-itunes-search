//
//  SearchResultTableViewCell.swift
//  iTunes Search
//
//  Created by Sal Amer on 1/17/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    //ib Outlets
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var creatorLbl: UILabel!
    
    func updateViews() {
        guard let searchResult = searchResult else { return }
        titleLbl.text = searchResult.title
        creatorLbl.text = searchResult.creator
    }

}
