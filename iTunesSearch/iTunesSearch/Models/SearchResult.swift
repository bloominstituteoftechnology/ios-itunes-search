//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Chris Dobek on 4/6/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String?
    var creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
