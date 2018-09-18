//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Ilgar Ilyasov on 9/18/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Enum
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // MARK: - Properties
    
    private let baseURL = URL(string: "https://itunes.apple.com/")!
    var searchResults: [SearchResult] = []
    
    // MARK: - Fetching data
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        urlComponent.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponent.url else {
            NSLog("Search url is invalid: \(urlComponent)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error. No data returned: \(NSError())")
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                let results = searchResults.results
                completion(results, nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}
