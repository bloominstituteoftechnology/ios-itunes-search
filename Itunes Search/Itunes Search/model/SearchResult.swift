//
//  SearchResult.swift
//  Itunes Search
//
//  Created by Iyin Raphael on 9/18/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    var image: String
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case image = "artworkUrl60"
    }
}
struct SearchResults: Codable{
    let results: [SearchResult]
}



