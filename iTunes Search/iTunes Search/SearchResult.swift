//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Jeremy Taylor on 8/7/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
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
