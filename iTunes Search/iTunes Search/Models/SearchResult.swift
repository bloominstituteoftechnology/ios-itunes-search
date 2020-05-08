//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Bronson Mullens on 5/6/20.
//  Copyright © 2020 Bronson Mullens. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    /* A class/struct that adopts Codable will use the names
    of its properties as keys it should look for in the JSON
    file it is trying to decode. CodingKeys overrides this
    behavior.
    */
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
