//
//  SearchResult.swift
//  itunes Search
//
//  Created by Gi Pyo Kim on 10/1/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let results: [SearchResult]
}


struct SearchResult: Codable {
    var title: String?
    var creator: String?
    var artworkURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case artworkURL = "artworkUrl100"
    }
}
