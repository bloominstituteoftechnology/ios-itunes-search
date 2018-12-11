//
//  SearchResult.swift
//  ios-itunes-search
//
//  Created by Vijay Das on 12/11/18.
//  Copyright © 2018 Vijay Das. All rights reserved.
//

import UIKit

struct SearchResult: Codable {
    
    var title: String
    var creator: String
}

struct SearchResults: Codable {
    var results: [SearchResult]
    
    
}

enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case creator = "artistName"
}

