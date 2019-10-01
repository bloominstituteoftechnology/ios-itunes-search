//
//  SearchResultTableViewCell.swift
//  itunes Search
//
//  Created by Gi Pyo Kim on 10/1/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    
    private func updateViews() {
        guard let searchResult = searchResult else { return }
        
        if let imageURL = URL(string: searchResult.artworkURL) {
            cellImageView.load(url: imageURL)
        }
        titleLabel.text = searchResult.title
        creatorLabel.text = searchResult.creator
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
