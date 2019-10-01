//
//  SearchResultsTableViewCell.swift
//  iTunes Search
//
//  Created by Jesse Ruiz on 10/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    // MARK: - Properties
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let searchResult = searchResult else { return }
        
        titleName.text = searchResult.title
        artistName.text = searchResult.creator
    }
    

}
