//
//  SaerchResult.swift
//  iTunesSearch
//
//  Created by Jessie Ann Griffin on 9/8/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
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

struct SearchResults: Codable {
    let results: [SearchResult]
}
