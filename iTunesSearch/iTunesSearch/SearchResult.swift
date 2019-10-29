//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Lambda_School_Loaner_204 on 10/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String?
    let creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName" //trackName
        case creator = "artistName" //artistName
    }
}

struct SearchResults : Codable {
    let results: [SearchResult]
}
