//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Nihal Erdal on 4/6/20.
//  Copyright © 2020 Nihal Erdal. All rights reserved.
//

import Foundation

struct SearchResult: Codable{
    
    let title : String
    let creator : String
    
    enum CodingKeys: String, CodingKey {

        case title = "trackName"
        case creator = "artistName"
    }
    
    struct SearchResults {
        let results: [SearchResult]
    }
}
