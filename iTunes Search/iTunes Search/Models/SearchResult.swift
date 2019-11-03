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
    let imageURL100: String
    let imageURL512: String?
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case imageURL100 = "artworkUrl100"
        case imageURL512 = "artworkUrl512"
        case link = "trackViewUrl"
    }
}

struct SearchResults: Decodable {
    var results: [SearchResult]
}
