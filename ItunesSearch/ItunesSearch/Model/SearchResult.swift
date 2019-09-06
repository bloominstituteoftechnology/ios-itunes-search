//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Fabiola S on 9/6/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
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
