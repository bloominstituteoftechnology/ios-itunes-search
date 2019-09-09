//
//  SearchResult.swift
//  ios-itunes-search
//
//  Created by Casualty on 9/8/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import Foundation

struct SearchResult: Codable, Equatable {
    let title: String
    let creator: String
    let imageURL: String
    var imageData: Data? = nil
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case imageURL = "artworkUrl60"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
