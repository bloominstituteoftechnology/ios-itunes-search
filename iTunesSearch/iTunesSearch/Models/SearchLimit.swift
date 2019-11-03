//
//  SearchLimit.swift
//  iTunesSearch
//
//  Created by Joseph Rogers on 11/2/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import Foundation

struct SearchLimit: Codable {
    var limit: String?
    
    enum CodingKeys: String, CodingKey {
        case limit = "limit"
    }
}
struct SearchLimitResults: Codable {
    let Searchresults: [SearchLimit]
}
