//
//  TableViewCellController.swift
//  iTunes Lookup
//
//  Created by Austin Cole on 12/5/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class TableViewCellController: UITableViewCell {
    static let shared = TableViewCellController()

    @IBOutlet weak var workLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
}
