//
//  SearchResult.swift
//  itunesSearch
//
//  Created by Matthew Martindale on 3/12/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
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
