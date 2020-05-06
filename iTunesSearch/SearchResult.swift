//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Kenneth Jones on 5/6/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
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
