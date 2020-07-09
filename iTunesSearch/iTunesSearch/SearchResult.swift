//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Dojo on 7/8/20.
//  Copyright © 2020 Dojo. All rights reserved.
//

import UIKit

struct SearchResult: Codable {
    var title: String
    var creator: String
}

struct SearchResults: Codable {
    let results: [SearchResult]
}

enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case creator = "artistName"
}

    
