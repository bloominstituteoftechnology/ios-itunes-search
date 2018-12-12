//
//  SearchResult.swift
//  iTune Search
//
//  Created by Ivan Caldwell on 12/11/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation

// It seems like the structs are backwards. I don't know why?
struct Result: Codable {
    let title: String
    let creator: String
    
    // The coding key enum is used the class/struct properties
    // do not much the JSON keys
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    struct Results: Codable {
        let results: [Result]
    }
}


