//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Josh Kocsis on 5/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
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

struct SearchResults: Decodable {
    let results: [SearchResult]
}

