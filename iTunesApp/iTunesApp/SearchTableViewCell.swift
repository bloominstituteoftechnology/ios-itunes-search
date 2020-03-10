//
//  SearchTableViewCell.swift
//  iTunesApp
//
//  Created by Lydia Zhang on 3/10/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let searchResult = searchResult else {return}
        
        title.text = searchResult.title
        name.text = searchResult.creator
    }

}
