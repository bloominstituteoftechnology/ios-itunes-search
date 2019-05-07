//
//  MovieDetailViewController.swift
//  iTunesSearch
//
//  Created by Jeffrey Carpenter on 5/7/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        
        guard let movie = searchResult,
        isViewLoaded
        else { return }
    
        // Set the labels and textView
        nameLabel.text = movie.title
        creatorLabel.text = movie.creator
        descriptionTextView.text = movie.description
        
        if let price = movie.price {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = nil
        }
        
    }
}
