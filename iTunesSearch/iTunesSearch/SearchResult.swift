//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by morse on 10/29/19.
//  Copyright © 2019 morse. All rights reserved.
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
