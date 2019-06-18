//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Kat Milton on 6/18/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping(Error?) -> Void) {
       
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryIem = URLQueryItem(name: "term", value: searchTerm)
        let resultCategoryQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryIem, resultCategoryQuery]
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, result, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                print("No data returned from task.")
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let itunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = itunesSearch.results
                completion(nil)
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
        
    }
}

