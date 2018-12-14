//
//  SearchTableViewCell.swift
//  iTunes Search
//
//  Created by Sameera Leola on 12/12/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let reuseIdentifier =  "iTunesDataCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var artWorkImage: UIImageView!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let searchResult = searchResult else { return }
        titleLabel.text = searchResult.title
        detailLabel.text = searchResult.creator
        artWorkImage.image = getArtWork()
    }
    
    func getArtWork() -> UIImage {
        
        guard let url = URL(string: searchResult?.artWork), let imageData = try? Data(contentsOf: url) else { return }
            return UIImage(data: imageData)
        //Build the url to the photo image.  Either the imageData will be in the imageData variable or the try will set it to Nil
        //URL changes a string to a URL
        
        //        guard let url = URL(string: photo.urls.thumb), let imageData = try? Data(contentsOf: url)  else { return cell }
        //        cell.imageView?.image = UIImage(data: imageData)
        //
        //        return cell
    }
    
    
}
