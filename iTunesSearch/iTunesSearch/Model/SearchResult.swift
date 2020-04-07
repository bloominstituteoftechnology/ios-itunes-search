//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Nichole Davidson on 4/6/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
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

extension SearchResult: Hashable {
    
}

struct SearchResults: Decodable {
    let results: [SearchResult]
}
