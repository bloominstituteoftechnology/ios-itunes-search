//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Ryan Murphy on 5/14/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation


struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    var title: String?
    var creator: String?
}

struct SearchResults: Codable {
    var results: [SearchResult]
    
}
