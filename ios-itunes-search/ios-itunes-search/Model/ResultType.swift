//
//  ResultType.swift
//  ios-itunes-search
//
//  Created by Benjamin Hakes on 12/5/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import Foundation

enum ResultType: String, CodingKey {
    case music = "musicTrack"
    case app = "software"
    case movie = "movie"
}
