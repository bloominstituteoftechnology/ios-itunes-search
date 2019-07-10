//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Kat Milton on 7/9/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    let trackTime: Int?
    let kind: String
    let artwork: String?
    let preview: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case trackTime = "trackTimeMillis"
        case kind = "kind"
        case artwork = "artworkUrl100"
        case preview = "previewUrl"
    }
    
    
    
}

struct SearchResults: Codable {
    let results: [SearchResult]
}


