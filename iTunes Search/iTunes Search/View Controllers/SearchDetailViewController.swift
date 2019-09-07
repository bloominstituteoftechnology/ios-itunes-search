//
//  SearchDetailViewController.swift
//  iTunes Search
//
//  Created by Eoin Lavery on 07/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchAuthorLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var viewContentButton: UIButton!
    
    
    // MARK: - Properties
    var result: SearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchImageView.layer.cornerRadius = 45.0
        viewContentButton.layer.cornerRadius = 10.0
        title = result?.title
    }
    
    func updateViews() {
        guard let result = result else { return }
        searchTitleLabel?.text = result.title
        searchAuthorLabel?.text = result.creator
        
        guard let imageURL = URL(string: result.imageURL) else { return }
        searchImageView?.load(url: imageURL)
    }
    
    func viewURL() {
        guard let result = result,
                let viewURL = URL(string: result.link) else { return }
        UIApplication.shared.open(viewURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func viewButtonTapped(_ sender: Any) {
        viewURL()
    }
    
}

