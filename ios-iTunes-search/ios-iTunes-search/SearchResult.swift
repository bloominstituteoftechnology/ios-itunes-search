//
//  SearchResult.swift
//  ios-iTunes-search
//
//  Created by Lambda_School_Loaner_268 on 2/11/20.
//  Copyright © 2020 Lambda. All rights reserved.
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

struct SearchResults: Decodable {
    let results:  [SearchResult]
}
