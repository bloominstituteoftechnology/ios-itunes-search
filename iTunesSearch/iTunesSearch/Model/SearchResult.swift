//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Shawn James on 4/6/20.
//  Copyright © 2020 Shawn James. All rights reserved.
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
    let results = [SearchResult]()
}
