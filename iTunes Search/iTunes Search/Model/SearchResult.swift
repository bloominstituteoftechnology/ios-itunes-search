//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Madison Waters on 9/18/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    var title: String
    var artist: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artist = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}

