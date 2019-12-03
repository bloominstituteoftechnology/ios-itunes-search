//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Chad Rutherford on 12/3/19.
//  Copyright © 2019 chadarutherford.com. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String?
    let creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
