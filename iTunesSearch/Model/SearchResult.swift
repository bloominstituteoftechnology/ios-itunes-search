//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Nathan Hedgeman on 6/8/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    let title  : String
    let creator: String
 
    
    
    enum CodingKeys: String, CodingKey {
        case title   = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    
    let results: [SearchResult]
    
}
