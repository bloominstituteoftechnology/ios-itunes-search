//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Sammy Alvarado on 7/8/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation

enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case creator = "artistName"
}

struct SearchResult: Codable {
    var tile: String
    var creator: String
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
