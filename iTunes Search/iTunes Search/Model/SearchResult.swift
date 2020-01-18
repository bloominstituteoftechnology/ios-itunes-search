//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Joshua Rutkowski on 1/17/20.
//  Copyright © 2020 Rutkowski. All rights reserved.
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

struct SearchResults: Decodable {
    let results: [SearchResult]
}
