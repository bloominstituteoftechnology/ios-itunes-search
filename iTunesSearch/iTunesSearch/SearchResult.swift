//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Enrique Gongora on 2/11/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
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

// Struct used to decode the JSON data we need
struct SearchResults: Codable {
    let results: [SearchResult]
}
