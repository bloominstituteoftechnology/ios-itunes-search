//
//  SearchResultController.swift
//  ITunesSearch
//
//  Created by Taylor Lyles on 5/14/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import Foundation


class SearchResultController {
	let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
	var searchResults: [SearchResult] = []
	
	func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
		
		let searchURL = baseURL.appendingPathComponent("searchResults")
		
		var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)

		let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
		
		urlComponents?.queryItems = [searchQueryItem]
		
		guard let formattedURL = urlComponents?.url else {
			completion()
			return
		}
		
		var request = URLRequest(url: formattedURL)
		
		request.httpMethod = HTTPMethod.get.rawValue
		
		let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				NSLog("Error searching for media: \(error)")
				completion()
				return
			}
			
			guard let data = data else {
				NSError("Error, no data")
				completion()
				return
			}
			
			do {
				
				let decoder = JSONDecoder()
				
				let musicResults = try decoder.decode(SearchResult.self, from: data)
				
				self.searchResults = musicResults.results
				
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

