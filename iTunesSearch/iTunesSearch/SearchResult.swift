//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Chris Gonzales on 2/11/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    var title: String
    var creator: String
    
    
    enum CodingKeys: String, CodingKey{
        case title = "trackName"
        case creator = "artistName"
        
    }
    
}


struct SearchResults{
    
    var results: [SearchResult]
}
