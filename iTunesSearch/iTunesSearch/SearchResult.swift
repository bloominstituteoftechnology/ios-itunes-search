//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Thomas Cacciatore on 5/21/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    let title:  String?
    let creator: String?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case creator = "artistName"
        
    }
    
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
