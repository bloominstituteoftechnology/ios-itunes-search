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
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}
struct SearchResults: Codable{
    let results: [SearchResult]
}



