//
//  ResultType.swift
//  ios-itunes-search
//
//  Created by Vijay Das on 12/11/18.
//  Copyright © 2018 Vijay Das. All rights reserved.
//

import UIKit

enum ResultType: String, CodingKey {
    case Apps = "software"
    case Music = "artistName"
    case Movies = "movie"
}

