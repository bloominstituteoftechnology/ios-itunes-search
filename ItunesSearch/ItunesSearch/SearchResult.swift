//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Keri Levesque on 2/11/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}
struct SearchResults { // does this need to be decodable protocol
    let results: [SearchResult]
}
