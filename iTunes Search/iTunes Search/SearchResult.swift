//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Dillon P on 9/7/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
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


struct SearchResults: Decodable {
    let results: [SearchResult]
}
