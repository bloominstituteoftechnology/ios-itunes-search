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
<<<<<<< HEAD
        guard let searchResult = serchResult else { return }
        
=======
        guard let searchResult = searchResult else { return }
>>>>>>> 990b387daa577ad5f1c0b29cd5815bbaff4019c0
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
    

    
} //End of class
