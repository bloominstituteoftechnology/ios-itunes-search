//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Jeffrey Carpenter on 5/7/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    var title: String?
    var collection: String?
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case collection = "collectionName"
        case creator = "artistName"
    }
}

struct SearchResults: Decodable {
    var results: [SearchResult]
}
