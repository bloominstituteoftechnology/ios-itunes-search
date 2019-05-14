//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Kobe McKee on 5/14/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        
    }
    
    var title: String?
    var creator: String?
    
}


struct SearchResults: Codable {
    
    let results: [SearchResult]
    
    
}

