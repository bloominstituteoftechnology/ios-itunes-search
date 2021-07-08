//
//  SearchResultController.swift
//  itunes-search
//
//  Created by Hector Steven on 5/7/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

//https://itunes.apple.com/search?term=thestrokes&entity=musicTrack
//https://itunes.apple.com/search?term=twitter&entity=software
//https://itunes.apple.com/search?term=Tron&entity=movie

class SearchResultController {
	
	func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
		var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		let searchTermQuery = URLQueryItem(name: "term", value: searchTerm)
		let entityQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
		urlComponents?.queryItems = [searchTermQuery, entityQuery]

		guard let requestURL = urlComponents?.url else {
			NSLog("requestURL is nill)")
			completion(nil)
			return
		}
		
		print(requestURL)
		
		var request = URLRequest(url: requestURL)
		request.httpMethod = "GET"
		
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			
			if let error = error {
				NSLog("Error fetching data:\(error)")
				completion(error)
				return
			}
			
			guard let data = data else {
				NSLog("No data Returned")
				//NSError()
				return
			}
			
			let jsonDecoder = JSONDecoder()
			
			do{
				jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
				let personSearch = try jsonDecoder.decode(SearchResults.self, from: data)
				self.searchResults = personSearch.results
				completion(nil)
			} catch {
				completion(error)
				NSLog("Unable to decode data into object of type [SearchResult]")
			}
			
			
		}.resume()
		
	}
	
	private let baseURL = URL(string: "https://itunes.apple.com/search/")!
	private(set) var searchResults: [SearchResult] = []
}
