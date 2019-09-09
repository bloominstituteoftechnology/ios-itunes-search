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
    var cornerRadius: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        viewContentButton.layer.cornerRadius = 10.0
        updateViews()
        
        guard let cornerRadius = cornerRadius else { return }
        searchImageView.layer.cornerRadius = cornerRadius
    }
    
    func updateViews() {
        guard let result = result else { return }
        searchTitleLabel?.text = result.title
        searchAuthorLabel?.text = result.creator
        
        guard let imageURL100 = URL(string: result.imageURL100) else { return }
        
        if let imageURL512 = result.imageURL512 {
            guard let imageURL512 = URL(string: imageURL512) else { return }
            searchImageView.load(url: imageURL512)
        } else {
            searchImageView.load(url: imageURL100)
        }

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

