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
	
	let baseURL = URL(string: "https://itunes.apple.com/search?term=thestrokes")!
	private(set) var searchResults: [SearchResult] = []
	
	func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
		
	}
	
}
