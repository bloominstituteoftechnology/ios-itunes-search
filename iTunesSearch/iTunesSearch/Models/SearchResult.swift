//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Chris Dobek on 4/6/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var artistName: String?
    var trackName: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case trackName = "trackName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
