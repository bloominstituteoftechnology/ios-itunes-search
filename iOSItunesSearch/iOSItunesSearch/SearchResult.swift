//
//  SearchResult.swift
//  iOSItunesSearch
//
//  Created by denis cedeno on 11/3/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import Foundation
import UIKit

struct SearchResult: Codable {
    let title: String
    let creator: String
    

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        
    }
}

struct SearchResults: Decodable {
    var results: [SearchResult]
}
