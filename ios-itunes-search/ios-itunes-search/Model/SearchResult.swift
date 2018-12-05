//
//  SearchResult.swift
//  ios-itunes-search
//
//  Created by Benjamin Hakes on 12/5/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import Foundation

struct SearchResult: Codable{
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
}
