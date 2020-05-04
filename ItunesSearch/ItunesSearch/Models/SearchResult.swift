//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Nonye on 5/4/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
      }
    
    var title: String
    var creator: String
    
  
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
