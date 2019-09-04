//
//  Enums.swift
//  Itunes-Search
//
//  Created by Percy Ngan on 9/3/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation

enum ResultType: String {
	case app = "software"
	case music = "musicTrack"
	case movie
	case all
}

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}
