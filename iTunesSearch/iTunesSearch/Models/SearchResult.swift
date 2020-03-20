//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Lambda_School_loaner_226 on 3/15/20.
//  Copyright © 2020 JamesMcDougall. All rights reserved.
//

import Foundation


struct SearchResult: Codable {
    var title: String
    var creator: String

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults {
    let results: [SearchResult]
}
