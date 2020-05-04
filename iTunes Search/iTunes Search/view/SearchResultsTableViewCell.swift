//
//  SearchResultsTableViewCell.swift
//  iTunes Search
//
//  Created by Vincent Hoang on 5/4/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit
import os.log

class SearchResultsTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var creatorLabel: UILabel!
    @IBOutlet var resultImage: UIImageView!
    
    var searchResult: SearchResult? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if let result = searchResult {
            titleLabel.text = result.title
            creatorLabel.text = result.creator
            
            if let url = URL(string: result.artwork) {
                print(url.absoluteString)
                
               let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if let error = error {
                    os_log("Error fetching data: %@", log: OSLog.default, type: .error, "\(error)")
                    return
                }
                
                guard let data = data else {
                    os_log("No data returned from data task.", log: OSLog.default, type: .error)
                    return
                }
                
                DispatchQueue.main.async {
                    if let imageDownload = UIImage(data: data) {
                        self.resultImage.image = imageDownload
                    }
                }
                return
                })
                task.resume()
            }
        }
    }
}
