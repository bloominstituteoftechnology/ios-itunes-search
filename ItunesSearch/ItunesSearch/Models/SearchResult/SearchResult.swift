//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by brian vilchez on 9/4/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    var title: String
    var creator: String
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
