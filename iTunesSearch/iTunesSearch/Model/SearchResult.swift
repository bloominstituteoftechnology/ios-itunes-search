//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Michael on 1/14/20.
//  Copyright © 2020 Michael. All rights reserved.
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
