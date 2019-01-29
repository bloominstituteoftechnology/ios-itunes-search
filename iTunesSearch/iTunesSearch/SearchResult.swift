//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Paul Yi on 1/29/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
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

struct SearchResults {
    let results: [SearchResult]
}
