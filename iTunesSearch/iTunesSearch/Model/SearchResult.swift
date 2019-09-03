//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Alex Rhodes on 9/3/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
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
