//
//  MahDataGetter.swift
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

class MahDataGetter {

	enum HTTPError: Error {
		case non200StatusCode
		case noData
	}

	func fetchMahDatas(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				print("error getting url '\(request.url ?? URL(string: "")!)': \(error)")
				completion(nil, error)
				return
			} else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
				print("non 200 http response: \(response.statusCode)")
				let myError = HTTPError.non200StatusCode
				completion(nil, myError)
				return
			}

			guard let data = data else {
				completion(nil, HTTPError.noData)
				return
			}
			completion(data, nil)
			}.resume()
	}
}
