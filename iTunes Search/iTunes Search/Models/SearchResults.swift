//
//  SearchResults.swift
//  iTunes Search
//
//  Created by Linh Bouniol on 8/7/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var artist: String
}

// When the properties you create don't match the properties in the JSON, you can use CodingKeys in an enum to map the keys from the JSON to the properties you want their values to be stored in.

enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case artist = "artistName"
}

// The JSON objects that represent each SearchResult (title, artist) are nested in the JSON key "results".
// If you try to decode the data, it won't work.
// You need to create an object that represents the JSON key "results".

struct SearchResults: Codable {
    let results: [SearchResult]
}

// Now, you can decode the JSON data into the object above, and access the search results through its "results" property.
