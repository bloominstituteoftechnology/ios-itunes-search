//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Claudia Contreras on 3/13/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
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
