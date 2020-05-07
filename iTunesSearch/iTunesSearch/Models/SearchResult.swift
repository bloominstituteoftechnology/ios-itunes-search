//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Aaron Peterson on 5/5/20.
//  Copyright © 2020 Aaron Peterson. All rights reserved.
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

struct SearchResults {
    let results: [SearchResult]
}
