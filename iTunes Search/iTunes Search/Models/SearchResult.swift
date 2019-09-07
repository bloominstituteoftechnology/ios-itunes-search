//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Joel Groomer on 9/7/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var creator: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case creator = "artistName"
        case title = "trackName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
