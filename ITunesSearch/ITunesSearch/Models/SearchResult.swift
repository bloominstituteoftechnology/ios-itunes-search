//
//  SearchResult.swift
//  ITunesSearch
//
//  Created by Nick Nguyen on 2/11/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

struct SearchResult : Codable {
    let title: String?
    let creator : String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}
struct SearchResults : Codable {
    let results : [SearchResult]
    
}
