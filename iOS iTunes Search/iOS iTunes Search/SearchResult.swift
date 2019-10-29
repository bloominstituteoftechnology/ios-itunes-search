//
//  SearchResult.swift
//  iOS iTunes Search
//
//  Created by Brandi on 10/29/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults {
    let results: [SearchResult]
    
}
