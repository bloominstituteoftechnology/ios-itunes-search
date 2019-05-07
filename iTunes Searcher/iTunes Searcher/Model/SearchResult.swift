//
//  File.swift
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
	enum CodingKeys: String, CodingKey {
		case title = "trackName"
		case creator = "artistName"
	}

	let title: String
	let creator: String
}

struct SearchResults: Decodable {
	let results: [SearchResult]
}
