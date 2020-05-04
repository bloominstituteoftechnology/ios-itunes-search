//
//  SearchResult.swift
//  Itunes Search
//
//  Created by Kelson Hartle on 5/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
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
