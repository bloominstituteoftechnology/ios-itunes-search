//
//  SearchResult.swift
//  itunesSearch
//
//  Created by Bradley Yin on 8/6/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    enum CodingKeys: String, CodingKey{
        case title = "trackName"
        case creator = "artistName"
    }
    let title : String
    let creator: String
}

struct SearchResults: Codable{
    let results: [SearchResult]
}
