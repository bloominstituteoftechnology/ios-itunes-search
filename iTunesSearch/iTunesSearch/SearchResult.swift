//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Farhan on 9/11/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String , CodingKeys {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults {
    let results: [SearchResult]
}
