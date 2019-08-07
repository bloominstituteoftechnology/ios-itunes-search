//
//  iTunesItem.swift
//  iTunes Search
//
//  Created by Nathan Hedgeman on 8/6/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//



import Foundation


struct SearchResult: Codable {
    
    let title: String
    let creator: String
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case creator = "artistName"
    }
}

struct BaseResults: Codable {
    
    let result: [SearchResult]
}


