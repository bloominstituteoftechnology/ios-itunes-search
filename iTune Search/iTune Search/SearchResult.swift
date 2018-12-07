//
//  SearchResult.swift
//  iTune Search
//
//  Created by Ivan Caldwell on 12/5/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
struct SearchResult: Codable {
    let title: String?
    let creator: String
    
    struct SearchResults: Codable {
        let results: [SearchResult]
    }
    
    enum CodingKeys: String, CodingKey {
        // Give it a raw value of "trackName"
        case title = "trackName"
        case creator = "artistName"
    }
    
}


