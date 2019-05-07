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

	static func resultTypeFromString(_ string: String) -> ResultType {
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

	static func resultTypeFromIndex(_ index: Int) -> ResultType {
		switch index {
		case 0:
			return .software
		case 1:
			return .musicTrack
		case 2:
			return .movie
		default:
			return .musicTrack
		}
	}
}
