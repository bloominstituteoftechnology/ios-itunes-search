//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Harm on 5/2/23.
//

import Foundation

struct SearchResult: Codable {
    var title: String?
    var collectionName: String?
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case collectionName
    }
    
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
