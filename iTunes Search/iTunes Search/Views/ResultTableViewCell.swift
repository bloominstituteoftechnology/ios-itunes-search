//
//  ResultTableViewCell.swift
//  iTunes Search
//
//  Created by Joel Groomer on 9/7/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCreator: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateViews() {
        guard let searchResult = searchResult else { return }
        lblTitle.text = searchResult.title
        lblCreator.text = searchResult.creator
    }
}
