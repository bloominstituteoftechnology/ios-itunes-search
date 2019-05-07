//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Lisa Sampson on 5/7/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
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
