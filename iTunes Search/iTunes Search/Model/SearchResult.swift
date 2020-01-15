//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Aaron Cleveland on 1/14/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
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
