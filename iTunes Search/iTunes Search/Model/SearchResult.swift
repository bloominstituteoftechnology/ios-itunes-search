//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Sammy Alvarado on 7/8/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
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
