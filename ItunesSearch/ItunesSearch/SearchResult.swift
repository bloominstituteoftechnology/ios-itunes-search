//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Elizabeth Wingate on 2/11/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
     case title = "trackName"
     case creator = "artistName"
    }
    
    struct SearchResults: Decodable {
        let results: [SearchResult]
    }
}
