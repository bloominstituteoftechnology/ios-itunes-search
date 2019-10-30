//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by brian vilchez on 9/4/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

struct Artist: Codable {
    let trackName: String
    let artistName: String
    
    enum CodingKeys: String,CodingKey {
        case trackName
        case artistName
    }
}

struct ArtistSearchResults: Codable {
    var results: [Artist]
}

