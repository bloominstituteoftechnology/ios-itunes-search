//
//  ResultType.swift
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

enum ResultType: String {
	case software
	case musicTrack
	case movie

	func resultTypeFromString(_ string: String) -> ResultType {
		switch string {
		case "software":
			return .software
		case "musicTrack":
			return .musicTrack
		case "movie":
			return .movie
		default:
			return .musicTrack
		}
	}
}
