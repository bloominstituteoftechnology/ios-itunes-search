//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Harmony Radley on 4/6/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    var title: String
    var creator: String
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
