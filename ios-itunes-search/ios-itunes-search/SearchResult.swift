//
//  SearchResult.swift
//  ios-itunes-search
//
//  Created by Ahava on 5/1/20.
//  Copyright © 2020 Ahava. All rights reserved.
//

import Foundation

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
