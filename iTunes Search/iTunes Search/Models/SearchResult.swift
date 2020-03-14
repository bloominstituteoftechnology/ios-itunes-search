//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Juan M Mariscal on 3/13/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
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

struct SearchResults: Decodable {
    let results: [SearchResult]
}
