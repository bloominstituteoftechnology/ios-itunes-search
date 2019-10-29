//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Jon Bash on 2019-10-29.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String?
    var collectionName: String?
    var creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case collectionName
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
