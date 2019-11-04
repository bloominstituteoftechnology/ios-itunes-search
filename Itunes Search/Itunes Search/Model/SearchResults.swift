//
//  SearchResults.swift
//  Itunes Search
//
//  Created by Nicolas Rios on 11/2/19.
//  Copyright © 2019 Nicolas Rios. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
}
   

struct searchResults: Codable {
    let results: [SearchResult]
}



enum CodingKeys: String, CodingKey {
    case title = "TrackName"
    case creator = "artistName"
        
}




