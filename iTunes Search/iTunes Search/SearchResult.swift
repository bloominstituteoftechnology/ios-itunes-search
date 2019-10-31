//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Rick Wolter on 10/29/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    let title: String
    let creator: String
   

    
}
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        
        case artist = "artistName"
        
    }

    
    
struct SearchResults {
    
    let results: [SearchResult]
}
    

