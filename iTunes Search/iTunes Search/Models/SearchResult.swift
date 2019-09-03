//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Jordan Christensen on 9/4/19.
//  Copyright © 2019 Mazjap Co Technologies. All rights reserved.
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
