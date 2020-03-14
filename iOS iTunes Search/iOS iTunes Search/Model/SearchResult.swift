//
//  SearchResult.swift
//  iOS iTunes Search
//
//  Created by Elizabeth Thomas on 3/13/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
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
