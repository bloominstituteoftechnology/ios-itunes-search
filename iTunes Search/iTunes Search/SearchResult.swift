//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Mitchell Budge on 5/14/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults {
    let results: [SearchResult]
}
