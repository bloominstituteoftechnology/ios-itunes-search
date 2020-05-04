//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Vincent Hoang on 5/4/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation


struct SearchResult: Codable {
    let title: String
    let creator: String
    let artwork: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case artwork = "artworkUrl60"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
