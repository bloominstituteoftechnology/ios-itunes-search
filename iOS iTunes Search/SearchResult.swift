//
//  SearchResult.swift
//  iOS iTunes Search
//
//  Created by Andrew Ruiz on 9/3/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
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


struct SearchResults: Codable {
    var results: [SearchResult]
}
