//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Sameera Leola on 12/12/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    var artWork: String
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case artWork = "artworkUrl60"
    }
}

//Customize the results we want
struct SearchResults: Codable {
    let results: [SearchResult]
}





