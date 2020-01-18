//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Sal Amer on 1/17/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
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
 
