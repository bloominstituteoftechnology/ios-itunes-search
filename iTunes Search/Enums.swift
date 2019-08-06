//
//  Enums.swift
//  iTunes Search
//
//  Created by Jeffrey Santana on 8/6/19.
//  Copyright © 2019 Lambda. All rights reserved.
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
