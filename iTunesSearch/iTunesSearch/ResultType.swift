//
//  ResultType.swift
//  iTunesSearch
//
//  Created by Jorge Alvarez on 1/14/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

enum ResultType: String, Decodable {
    case software = "software"
    case musicTrack = "musicTrack"
    case movie = "movie"
}
