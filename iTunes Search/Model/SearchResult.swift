//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Andrew Ruiz on 10/1/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    struct SearchResults: Codable {
        
        results: [SearchResult]
    }
    
    
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case creator = "artistName"

    }
}
