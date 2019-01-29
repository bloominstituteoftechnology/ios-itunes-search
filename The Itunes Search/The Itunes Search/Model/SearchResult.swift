//
//  SearchResult.swift
//  The Itunes Search
//
//  Created by Michael Flowers on 1/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct SearchResult: Codable { // this is constructing our model or the data we want to get back from the network call
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey { //you use this when the names don't quiet match up
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult] //this will allow us us to decode the JSON data into this object, then access the actual search results through its results property
}
