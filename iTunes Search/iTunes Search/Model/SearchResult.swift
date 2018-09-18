//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Scott Bennett on 9/18/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
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
