//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by David Wright on 1/17/20.
//  Copyright © 2020 David Wright. All rights reserved.
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
