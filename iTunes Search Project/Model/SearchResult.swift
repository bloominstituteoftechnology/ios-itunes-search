//
//  SearchResult.swift
//  iTunes Search Project
//
//  Created by macbook on 10/1/19.
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
    var results: [SearchResult] = [] // I added the empty array
}
