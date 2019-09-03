//
//  SearchResult.swift
//  iTunesList
//
//  Created by Austin Potts on 9/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
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
