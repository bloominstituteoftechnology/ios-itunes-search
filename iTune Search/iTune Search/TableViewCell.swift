//
//  TableViewCell.swift
//  iTune Search
//
//  Created by Ivan Caldwell on 12/5/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    static let reuseIdentifier = "cell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
}
