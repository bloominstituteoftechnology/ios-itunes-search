//
//  SearchResultDetailViewController.swift
//  ios-itunes-search
//
//  Created by De MicheliStefano on 07.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class SearchResultDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let searchResult = searchResult else { return }
        print(searchResult.description)
        titleTextLabel?.text = searchResult.title
        creatorTextLabel?.text = searchResult.creator
        descriptionTextView?.text = searchResult.description
    }
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var creatorTextLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
}
