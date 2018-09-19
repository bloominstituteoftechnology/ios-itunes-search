//
//  SearchTableViewCell.swift
//  Itunes Search
//
//  Created by Iyin Raphael on 9/19/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    var searchResult: SearchResult?{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        if let searchResult = searchResult{
            titleLabel.text = searchResult.title
            creatorLabel.text = searchResult.creator
            guard let urlImage = URL(string: searchResult.image),
            let data = try? Data(contentsOf: urlImage) else {return}
            artistImage.image = UIImage(data: data)
            }
        }
    
    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    

}
