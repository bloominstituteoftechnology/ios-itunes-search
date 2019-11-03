//
//  SearchResult.swift
//  Itunes
//
//  Created by Alex Thompson on 11/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
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

enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case creator = "artistName"
}
