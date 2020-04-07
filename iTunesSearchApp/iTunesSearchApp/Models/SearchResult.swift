//
//  Model.swift
//  iTunesSearchApp
//
//  Created by Mark Poggi on 4/6/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
           case title = "trackName"
           case artist = "artistName"
       }
    
    var title: String?
    var artist: String?
    
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
