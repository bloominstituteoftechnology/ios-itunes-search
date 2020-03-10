//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Wyatt Harrell on 3/10/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
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
