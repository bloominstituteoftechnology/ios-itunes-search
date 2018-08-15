//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Lisa Sampson on 8/14/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String?
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
