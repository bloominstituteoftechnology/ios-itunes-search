//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Bree Jeune on 3/17/20.
//  Copyright © 2020 Young. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
