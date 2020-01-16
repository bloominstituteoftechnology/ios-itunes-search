//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Zack Larsen on 12/3/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
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
