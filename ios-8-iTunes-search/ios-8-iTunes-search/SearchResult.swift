//
//  SearchResult.swift
//  ios-8-iTunes-search
//
//  Created by Alex Shillingford on 8/6/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    let title: String
    let creator: String
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
