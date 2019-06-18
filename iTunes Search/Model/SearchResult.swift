//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Kat Milton on 6/18/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
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

struct SearchResults: Decodable {
    let results: [SearchResult]
}
