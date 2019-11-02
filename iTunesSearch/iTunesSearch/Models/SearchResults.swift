//
//  SearchResults.swift
//  iTunesSearch
//
//  Created by Joseph Rogers on 11/1/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import Foundation
//our model which is conforming to the JSON format given.
struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    //this allows us to dig deeper into the JSON.
    struct SearchResults: Codable {
        let results: [SearchResult]
    }
}
