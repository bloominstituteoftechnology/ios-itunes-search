//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Jonathan Ferrer on 5/14/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

struct SearchResult: Codable {

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }


    let title: String
    let creator: String

}

struct SearchResults: Codable {

    let results: [SearchResult]



}
