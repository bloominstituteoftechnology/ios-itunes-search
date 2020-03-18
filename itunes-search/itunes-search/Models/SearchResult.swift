//
//  SearchResult.swift
//  itunes-search
//
//  Created by Jarren Campos on 3/13/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String?
    var creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
