//
//  SearchResult.swift
//  iTunes-Search
//
//  Created by Kenny on 1/14/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Decodable {
    let results: [SearchResult]
}
