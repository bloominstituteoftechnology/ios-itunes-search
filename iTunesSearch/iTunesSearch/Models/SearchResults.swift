//
//  SearchResults.swift
//  iTunesSearch
//
//  Created by Gerardo Hernandez on 1/21/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
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
