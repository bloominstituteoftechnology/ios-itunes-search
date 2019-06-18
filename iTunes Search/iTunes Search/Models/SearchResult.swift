//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Alex Shillingford on 6/18/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    // These are supposed to be optional bc there will be sometimes entities
    var title: String?
    var creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Decodable {
    let results: [SearchResult]
}
