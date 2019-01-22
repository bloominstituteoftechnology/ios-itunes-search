//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Nathanael Youngren on 1/22/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
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
    var results: [SearchResult]
//    var resultCount: Int
}
