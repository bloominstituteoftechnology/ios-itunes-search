//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Isaac Lyons on 10/1/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
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

struct SearchResults: Codable {
    let results: [SearchResult]
}
