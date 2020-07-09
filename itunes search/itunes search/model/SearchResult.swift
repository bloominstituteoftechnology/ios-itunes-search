//
//  SearchResult.swift
//  itunes search
//
//  Created by ronald huston jr on 5/4/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String?
    let creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    //  this will allow us to decode the JSON data into this object,
    //  then access the actual search results through the below property.
    var results: [SearchResult]
}

//  a class or struct that adopts Codable will by default use the names of its properties
//  as the keys it should look for in the JSON that it is trying to decode.
//  CodingKeys is part of Codable; allows us to (override the default behavior &)
//  map the keys from the JSON to the properties we want their values to be stored in.
