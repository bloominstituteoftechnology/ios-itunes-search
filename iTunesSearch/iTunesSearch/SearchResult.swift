//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Yvette Zhukovsky on 10/22/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
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


