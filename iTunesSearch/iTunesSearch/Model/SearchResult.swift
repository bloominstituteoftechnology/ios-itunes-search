//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Norlan Tibanear on 7/9/20.
//  Copyright © 2020 Norlan Tibanear. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String?
    let creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
