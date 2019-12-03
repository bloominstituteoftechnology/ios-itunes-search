//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Lambda_School_Loaner_218 on 12/3/19.
//  Copyright © 2019 Lambda_School_Loaner_218. All rights reserved.
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
    let ressults: [SearchResult]
}
