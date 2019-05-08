//
//  SearchResult.swift
//  itunes-search
//
//  Created by Hector Steven on 5/7/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


struct SearchResult: Codable {
	enum CodingKeys: String, CodingKey {
		case title = "trackName"
		case creator = "artistName"
	}
	let title: String?
	let creator: String?
	
}

struct SearchResults: Codable {
	let results: [SearchResult]
}
