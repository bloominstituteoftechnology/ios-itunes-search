//
//  SearchResultTableViewCell.swift
//  iTunes Search Project
//
//  Created by macbook on 10/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }  // TODO: - didSet?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - UpdateViews
    func updateViews() {
        guard let searchResult = searchResult else { return }
        
        titleLabel.text = searchResult.title
        artistLabel.text = searchResult.creator
    }

}
