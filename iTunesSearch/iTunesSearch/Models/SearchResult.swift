//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Hunter Oppel on 4/6/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    let title: String
    let creator: String
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
