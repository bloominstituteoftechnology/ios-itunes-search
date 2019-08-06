//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jeffrey Santana on 8/6/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class SearchResultController {
	private let baseURL = URL(string: "https://itunes.apple.com/search")!
	private(set) var searchResults = [SearchResult]()
	
	func performSearch(forSearch term: String, ofResult type: ResultType, _ completion: @escaping (Error?) -> Void) {
		var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		let searchTermQI = URLQueryItem(name: "term", value: term)
		let entityQI = URLQueryItem(name: "entity", value: type.rawValue)
		
		urlComponents?.queryItems = [searchTermQI,entityQI]
		
		guard let requestURL = urlComponents?.url else {
			NSLog("Request URL is nil")
			completion(NSError())
			return
		}
		var request = URLRequest(url: requestURL)
		request.httpMethod = HTTPMethod.get.rawValue
		
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			if let error = error {
				NSLog(error.localizedDescription)
				completion(error)
			}
			guard let data = data else {
				self.searchResults.removeAll()
				return
			}
			
			let jsonDecoder = JSONDecoder()
			do {
				let search = try jsonDecoder.decode(SearchResults.self, from: data)
				self.searchResults = search.results
			} catch {
				NSLog(error.localizedDescription)
				completion(error)
			}
			completion(nil)
		}.resume()
	}
}
