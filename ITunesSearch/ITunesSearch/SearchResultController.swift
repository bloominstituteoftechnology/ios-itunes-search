//
//  SearchResultController.swift
//  ITunesSearch
//
//  Created by Taylor Lyles on 5/14/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import Foundation


class SearchResultController {
	let baseURL = URL(string: "https://itunes.apple.com/search")!
	var searchResults: [SearchResult] = []
	
	func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
		
		let searchURL = baseURL.appendingPathComponent("searchResults")
		
		var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)

		let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
		
		let searchQueryType = URLQueryItem(name: "entity", value: resultType.rawValue)
		urlComponents?.queryItems = [searchQueryItem, searchQueryType]
		

		guard let formattedURL = urlComponents?.url else {
			NSLog("Not getting url")
			completion(nil)
			return
		}
		
		var request = URLRequest(url: formattedURL)
		
		request.httpMethod = HTTPMethod.get.rawValue
		
		let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
			if let error = error {
				NSLog("Error searching for media: \(error)")
				return
			}
			
			guard let data = data else {
				NSLog("Error, no data")
				return
			}
			
			
			do {
				
				let decoder = JSONDecoder()
				
				let results = try decoder.decode(SearchResults.self, from: data)
				
				self.searchResults = results.results
				
				completion(nil)
				
			} catch {
				NSLog("Error decoding: \(error)")
				completion(error)
			}
			
		}
		
		dataTask.resume()
		
		enum HTTPMethod: String {
			case get = "GET"
			case put = "PUT"
			case post = "POST"
			case delete = "DELETE"
		}
		
	}
}

