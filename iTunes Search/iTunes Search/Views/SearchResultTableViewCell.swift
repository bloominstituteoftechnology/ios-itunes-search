//
//  SearchResultTableViewCell.swift
//  iTunes Search
//
//  Created by Eoin Lavery on 07/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var searchResultNameLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    
    // MARK: - Properties
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let searchResult = searchResult else { return }
        searchResultNameLabel.text = searchResult.title
        createdByLabel.text = searchResult.creator
        
        guard let imageURL100 = URL(string: searchResult.imageURL100) else { return }
        
        if let imageURL512 = searchResult.imageURL512 {
            guard let imageURL512 = URL(string: imageURL512) else { return }
            print(imageURL512)
            searchImage.load(url: imageURL512)
        } else {
            searchImage.load(url: imageURL100)
        }
    }
    
    @IBAction func viewInStoreTapped(_ sender: Any) {
        guard let result = searchResult,
                let linkURL = URL(string: result.link) else { return }
        UIApplication.shared.open(linkURL, options: [:], completionHandler: nil)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
