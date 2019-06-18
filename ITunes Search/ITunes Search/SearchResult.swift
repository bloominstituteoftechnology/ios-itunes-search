//
//  SearchResult.swift
//  ITunes Search
//
//  Created by Sean Acres on 6/18/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String?
    let creator: String
    let collectionName: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case collectionName
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
