//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Carolyn Lea on 8/7/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation



struct SearchResult: Codable
{
    var title: String
    var creator: String
    enum CodingKeys: String, CodingKey
    {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable
{
    let results: [SearchResult]
}


