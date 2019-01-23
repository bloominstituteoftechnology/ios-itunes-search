//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Julian A. Fordyce on 1/22/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
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
