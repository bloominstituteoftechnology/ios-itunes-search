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
		case artworkURL = "artworkUrl100"
		case previewURL = "previewUrl"
	}

	let title: String
	let creator: String
	let artworkURL: String
	let previewURL: String?
	let uuid = UUID().uuidString
}

struct SearchResults: Decodable {
	let results: [SearchResult]
}
