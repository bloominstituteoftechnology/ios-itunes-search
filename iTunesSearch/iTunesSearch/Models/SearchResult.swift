//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Cora Jacobson on 7/8/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
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
