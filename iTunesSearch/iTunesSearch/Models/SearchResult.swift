//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Bhawnish Kumar on 3/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
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
