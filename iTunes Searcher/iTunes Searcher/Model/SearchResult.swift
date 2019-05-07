//
//  File.swift
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
	let title: String
	let creator: String

//	enum CodingKeys: String, CodingKey {
//		case title = "trackName"
//		case createor = "artistName"
//	}
}

struct SearchResults {
	let results: [SearchResult]
}
