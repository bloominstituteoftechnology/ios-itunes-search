//
//  SearchResult.swift
//  ios-iTunes-search
//
//  Created by Lambda-School-Loaner-11 on 8/7/18.
//  Copyright © 2018 Lambda-School-Loaner-11. All rights reserved.
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

struct SearchResults: Codable {
    let results: [SearchResult]
}


