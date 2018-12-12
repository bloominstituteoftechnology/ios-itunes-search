//
//  SearchResultController.swift
//  iTune Search
//
//  Created by Ivan Caldwell on 12/11/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation

class SearchResultController {
    // Variables and Constants
    let baseURL = URL(string: "https://itunes.apple.com/search")
    var results: [Result] = []
    
    // Functions
    func perfomrSearch(searchTerm: String, resultType: ResultType, completion:  @escaping (NSError?) -> Void) {
        guard var urlComponents = URLComponents(url: baseURL!, resolvingAgainstBaseURL: true)
            else { fatalError("Error: Bad URL")}
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchQueryItem, resultTypeQueryItem]
        let request = URLRequest(url: urlComponents.url!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data
                else {
                    if let error = error {
                        NSLog("Error fetching data: \(error)")
                        completion(NSError())
                    }
                return
            }
            do {
                let results = try JSONDecoder().decode(Result.Results.self, from: data)
                // I don't know how the results are distingushed from each other... lol
                self.results = results.results
                completion(NSError())
            } catch {
                NSLog("Unable to decode data:\n\(error)")
                completion(NSError())
            }
        }.resume()
    }
}
