//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Jeffrey Santana on 8/6/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
	
	enum CodingKeys: String, CodingKey {
		case title = "trackName"
		case creator = "artistName"
	}
	
	let title: String
	let creator: String
}

struct SearchResults: Codable {
	let results: [SearchResult]
}
