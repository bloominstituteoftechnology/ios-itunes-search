//
//  SearchResult.swift
//  iOS-iTunes-Search
//
//  Created by Vijay Das on 1/31/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
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
    var results: [SearchResult]
}

