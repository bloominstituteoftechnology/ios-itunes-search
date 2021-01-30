//
//  SearchResult.swift
//  iTunes Search
//
//  Created by James McDougall on 1/26/21.
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
    let results: [SearchResult]
}
