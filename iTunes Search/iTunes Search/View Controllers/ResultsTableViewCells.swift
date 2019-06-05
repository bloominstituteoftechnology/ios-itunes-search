//
//  SearchResultsTableViewCells.swift
//  iTunes Search
//
//  Created by Jason Modisett on 9/11/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

enum ResultCellsReuseIdentifiers: String {
    case appCell = "AppCell"
    case musicCell = "MusicCell"
    case movieCell = "MovieCell"
}

class AppCell: UITableViewCell {
    
    private func updateViews() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.frame = frame
        selectedBackgroundView?.backgroundColor = .clear
        appIconImageView.layer.borderWidth = 0.4
        appIconImageView.layer.borderColor = UIColor.lightGray.cgColor
        screenshotImageView.layer.borderWidth = 0.4
        screenshotImageView.layer.borderColor = UIColor.lightGray.cgColor
        screenshotImageView2.layer.borderWidth = 0.4
        screenshotImageView2.layer.borderColor = UIColor.lightGray.cgColor
        screenshotImageView3.layer.borderWidth = 0.4
        screenshotImageView3.layer.borderColor = UIColor.lightGray.cgColor
        
        guard let title = result?.title,
              let developer = result?.creator,
              let category = result?.appStoreCategory?.uppercased() else { return }
        
        appNameLabel.text = title
        developerNameLabel.text = developer
        categoryLabel.text = category
    }
    
    var result: SearchResult? { didSet { updateViews() }}

    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var developerNameLabel: UILabel!
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var screenshotImageView: UIImageView!
    @IBOutlet weak var screenshotImageView2: UIImageView!
    @IBOutlet weak var screenshotImageView3: UIImageView!
    
}


class MusicCell: UITableViewCell {
    
    private func updateViews() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.frame = frame
        selectedBackgroundView?.backgroundColor = .clear
        
        guard let title = result?.title,
            let artist = result?.creator,
            let album = result?.albumTitle else { return }
        
        trackNameLabel.text = title
        artistNameLabel.text = artist
        albumTitleLabel.text = album
    }
    
    
    var result: SearchResult? { didSet { updateViews() }}
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumArtworkView: UIImageView!
}


class MovieCell: UITableViewCell {
    
    private func updateViews() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.frame = frame
        selectedBackgroundView?.backgroundColor = .clear
        
        guard let title = result?.title,
            let director = result?.creator else { return }
        
        movieTitleLabel.text = title
        directedByLabel.text = "Directed by \(director)".uppercased()
    }
    
    var result: SearchResult? { didSet { updateViews() }}
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var directedByLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
}
