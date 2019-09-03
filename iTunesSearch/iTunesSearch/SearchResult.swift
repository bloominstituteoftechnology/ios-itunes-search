//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by admin on 9/3/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let results: [SearchResult]
}

struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    let title: String
    let creator: String
}
