//
//  SearchResults.swift
//  iTunesSearch
//
//  Created by alfredo on 1/19/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

struct SearchResult: Codable{
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey{
        case title = "trackName"
        case creator = "artistName"
    }
}
struct SearchResults: Decodable{
    let results: [SearchResult]
}
