//
//  SearchResult.swift
//  Itunes Search
//
//  Created by Morgan Smith on 1/17/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
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
