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
}

struct SearchResults {
    let results : [SearchResult]
}

enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case artist = "artistName"
}
