//
//  SearchResults.swift
//  iTunesSearch
//
//  Created by Lambda_School_Loaner_259 on 3/10/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
}

enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case creator = "artistName"
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
