//
//  ResultsTableViewCell.swift
//  ITunesSearch
//
//  Created by Taylor Lyles on 5/14/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

	private func updateViews() {
		guard let result = results else { return }
		
		title.text = result.title
		artist.text = result.creator
		}
	
	
	var results: SearchResult? {
		didSet {
			updateViews()
		}
	}
	
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var artist: UILabel!
	
}
