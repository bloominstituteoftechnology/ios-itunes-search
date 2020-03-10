//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Nichole Davidson on 3/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
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

//some result type on model should be optional
