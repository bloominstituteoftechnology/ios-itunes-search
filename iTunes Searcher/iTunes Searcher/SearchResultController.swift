//
//  SearchResultController.swift
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

class SearchResultController {
	let baseURL = URL(string: "https://itunes.apple.com/search")!

	let mahDataGetter = MahDataGetter()

	var searchResults = [SearchResult]()


	func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {

		var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		let searchQuery = URLQueryItem(name: "term", value: searchTerm)
		let mediaQuery = URLQueryItem(name: "media", value: resultType.rawValue)

		urlComponents?.queryItems = [searchQuery, mediaQuery]

		guard let url = urlComponents?.url else { return }
		let request = URLRequest(url: url)

		mahDataGetter.fetchMahDatas(with: request) { (data, error) in
			if let error = error {
				completion(error)
			}

			guard let data = data else { return }

			let decoder = JSONDecoder()
			do {
				let results = try decoder.decode(SearchResults.self, from: data)
				self.searchResults = results.results
				completion(nil)
			} catch {
				print("error decoding data: \(error)")
				completion(error)
			}
		}
	}
}
