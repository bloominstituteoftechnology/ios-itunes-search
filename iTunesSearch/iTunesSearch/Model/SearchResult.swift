//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Niranjan Kumar on 10/29/19.
//  Copyright © 2019 Nar LLC. All rights reserved.
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

struct AllSearchResults: Codable {
    var results: [SearchResult]
}
