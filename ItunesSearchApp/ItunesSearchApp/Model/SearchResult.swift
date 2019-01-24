//
//  SearchResult.swift
//  ItunesSearchApp
//
//  Created by Nelson Gonzalez on 1/22/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
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
