//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Ian French on 5/6/20.
//  Copyright © 2020 Ian French. All rights reserved.
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
    struct SearchResults: Decodable {
        
        var results: [SearchResult]
    }
    
    
    
    



