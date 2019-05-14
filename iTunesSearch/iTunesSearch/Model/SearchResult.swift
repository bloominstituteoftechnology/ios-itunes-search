//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Jeremy Taylor on 5/14/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
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
