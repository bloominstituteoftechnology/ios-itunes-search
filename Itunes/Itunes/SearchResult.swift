//
//  SearchResult.swift
//  Itunes
//
//  Created by Breena Greek on 3/13/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
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
