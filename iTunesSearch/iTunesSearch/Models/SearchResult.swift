//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Shawn Gee on 3/10/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
