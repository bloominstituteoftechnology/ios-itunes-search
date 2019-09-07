//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Eoin Lavery on 06/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import Foundation
import UIKit

struct SearchResult: Codable {
    let title: String
    let creator: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case imageURL = "artworkUrl100"
    }
}

struct SearchResults: Decodable {
    var results: [SearchResult]
}
