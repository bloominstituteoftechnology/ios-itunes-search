//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Rob Vance on 5/5/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
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
struct SearchResults: Decodable {
    let results: [SearchResult]
}
