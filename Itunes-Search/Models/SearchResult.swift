//
//  SearchResult.swift
//  Itunes-Search
//
//  Created by Percy Ngan on 9/3/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation


struct SearchResult: Codable {

	var title: String
	var creator: String

	enum CodingKeys: String, CodingKey {
		case title = "trackName"
		case creator = "artistName"
	}
}

struct SearchResults: Codable {

	let results: [SearchResult]
}
