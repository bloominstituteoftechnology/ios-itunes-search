//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by John Kouris on 9/7/19.
//  Copyright © 2019 John Kouris. All rights reserved.
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


