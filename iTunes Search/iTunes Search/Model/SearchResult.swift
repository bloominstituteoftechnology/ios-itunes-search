//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Welinkton on 9/18/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

struct SearchResult:Codable {
    let title: String?
    let artist: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artist = "artistName"
    }
}

struct SearchResults:Codable {
    let results: [SearchResult]
}

