//
//  SearchResult.swift
//  ios-itunes
//
//  Created by Angel Buenrostro on 1/22/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//
/*
Note: The JSON returned from the iTunes Search API refers to the developers of an application as the artistName, and the title of the search result as the trackName. The same goes for the trackName for the title of the search result. No matter whether it's music, movies, apps, etc. the JSON uses these same key-value pairs to keep the JSON consistent.
*/

import Foundation
import UIKit

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
