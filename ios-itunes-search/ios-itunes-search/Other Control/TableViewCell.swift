//
//  TableViewCell.swift
//  ios-itunes-search
//
//  Created by Benjamin Hakes on 12/5/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let reuseIdentifier = "cell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
}
