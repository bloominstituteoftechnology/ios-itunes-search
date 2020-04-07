//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Cameron Collins on 4/6/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    var artistName: String?
    var trackName: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case trackName = "primaryGenreName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
