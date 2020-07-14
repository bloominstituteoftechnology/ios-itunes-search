//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by John McCants on 7/9/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title : String
    var creator : String
    
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
