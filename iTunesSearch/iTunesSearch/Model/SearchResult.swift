//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Jonalynn Masters on 10/1/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import Foundation

// MARK: Properties

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
