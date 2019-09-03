//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Ciara Beitel on 9/3/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    let title: String
    let creator: String
}

struct SearchResults {
    let results: [SearchResult]
}
