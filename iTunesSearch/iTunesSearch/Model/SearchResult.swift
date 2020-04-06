//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Shawn James on 4/6/20.
//  Copyright © 2020 Shawn James. All rights reserved.
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

struct SearchResults {
    let results = [SearchResult]()
}
