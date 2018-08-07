//
//  SearchResultModel.swift
//  iTunesSearch
//
//  Created by William Bundy on 8/7/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import Foundation

struct SearchResult: Codable
{
	var title:String
	var creator:String

	enum CodingKeys: String, CodingKey
	{
		case title = "trackName"
		case creator = "artistName"
	}
}

struct SearchResultList: Codable
{
	var results:[SearchResult]
}

enum ResultType: String
{
	case software
	case music
	case movie

	static let all = [software, music, movie]
}

class SearchController
{
	static let noResults = SearchResult(title: "No results", creator:"")
	static let loading = SearchResult(title: "Loading", creator:"")
	static let itunesURL = URL(string:"https://itunes.apple.com/search?")!
	var results:[SearchResult] = []
	func search(_ term:String, type:ResultType, completion: @escaping (Error?)->Void)
	{
		var uc = URLComponents(url: SearchController.itunesURL, resolvingAgainstBaseURL: true)!
		uc.queryItems = [URLQueryItem(name:"term", value:term),
						 URLQueryItem(name:"media", value:type.rawValue)]

		guard let url = uc.url else {return}
		let req = URLRequest(url:url)
		URLSession.shared.dataTask(with: req) {	data, _, error in
			if let error = error {
				NSLog("Error requesting data \(error)")
				completion(error)
				return
			}

			guard let data = data else {
				NSLog("Error: got no data!")
				completion(NSError())
				return
			}

			do {
				let dec = JSONDecoder()
				//print(String(data:data, encoding:.utf8) ?? "No data")
				let res = try dec.decode(SearchResultList.self, from: data)
				self.results = res.results
				completion(nil)
			} catch {
				NSLog("Could not decode data")
				completion(NSError())
				return
			}
		}.resume()
	}
}
