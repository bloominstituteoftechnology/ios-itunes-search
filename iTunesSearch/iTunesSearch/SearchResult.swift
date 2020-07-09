//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by B$hady on 7/8/20.
//  Copyright © 2020 Lambda. All rights reserved.
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

struct searchResults {
    let results: [SearchResult]
}
