//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Moses Robinson on 1/22/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
