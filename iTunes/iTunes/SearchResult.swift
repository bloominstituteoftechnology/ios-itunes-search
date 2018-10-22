//
//  SearchResult.swift
//  iTunes
//
//  Created by Nikita Thomas on 10/22/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
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

struct ResultList: Codable {
    var results: [SearchResult]
}

