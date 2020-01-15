//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Ufuk Türközü on 14.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    var title: String
    var creator: String
    

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
}

struct SearchResults: Codable {
    let results: [SearchResult]
}

