//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Cora Jacobson on 7/9/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var searchResultController: SearchResultController?
    var searchResult: SearchResult?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = searchResult?.title
        creatorLabel.text = searchResult?.creator
    }

}
