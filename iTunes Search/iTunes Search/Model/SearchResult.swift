//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Jake Connerly on 6/18/19.
//  Copyright © 2019 jake connerly. All rights reserved.
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
}
