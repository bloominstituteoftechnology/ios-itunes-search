//
//  SearchResultController.swift
//  itunes-search
//
//  Created by Hector Steven on 5/7/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class SearchResultController {
	//https://itunes.apple.com/search?term=thestrokes&entity=musicTrack
	//https://itunes.apple.com/search?term=twitter&entity=software
	//https://itunes.apple.com/search?term=Tron&entity=movie
	
	let baseURL = URL(string: "https://itunes.apple.com/")!
	private(set) var searchResults: [SearchResult] = []
	
	func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
		
		var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
		let entityTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
		urlComponents?.queryItems = [searchTermQueryItem, entityTermQueryItem]
		
		guard let requestURL = urlComponents?.url else {
			NSLog("requestURL is nill)")
			completion(nil)
			return
		}
		
		var request = URLRequest(url: requestURL)
		request.httpMethod = "GET"
		
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			
			
			
			completion(error)
		}.resume()
		
	}
}
