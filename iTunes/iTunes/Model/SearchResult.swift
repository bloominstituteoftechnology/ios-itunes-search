//
//  SearchResult.swift
//  iTunes
//
//  Created by Hayden Hastings on 5/14/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
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
