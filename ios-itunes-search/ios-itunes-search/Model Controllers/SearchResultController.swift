//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by De MicheliStefano on 07.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    
    private enum HTTPMethod: String {
        // enum names by convention should be lowercase
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var queries: [(String, String)]
        
        if let country = country, let searchResultLimit = searchResultLimit {
            queries = [
                ("term", searchTerm),
                ("entity", resultType.rawValue),
                ("country", country),
                ("limit", searchResultLimit)
            ]
        } else {
            queries = [
                ("term", searchTerm),
                ("entity", resultType.rawValue)
            ]
        }
        
        guard let requestURL = generateURLComponents(baseURL: baseURL, queries: queries) else {
            NSLog("Error occured while constructing URL: \(searchTerm)")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if error != nil {
                NSLog("Error occured while fetching from iTunes: \(String(describing: error))")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error occured while fetching from iTunes for data")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(SearchResults.self, from: data)
                let result = results.results
                self.searchResults = result
                completion(nil)
                
            } catch {
                NSLog("Error occured while fetching from iTunes: \(error)")
                completion(error)
                return
            }
        }
        
        dataTask.resume()
    }
    
    private func generateURLComponents(baseURL: URL, queries: [(String, String)]) -> URL? {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return urlComponents.url
    }
    
    private func generateURLRequest(for url: URL, httpMethod: String ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
    
    func updateSettings(country: String?, searchLimit: String?) {
        if let country = country {
            self.country = country
        }
        if let searchLimit = searchLimit {
            self.searchResultLimit = searchLimit
        }
    }
    
    
    // TODO: Create a generic URLBuilder method that takes in baseurl, search querys and returns the request url
    
    var searchResults: [SearchResult] = []
    
    var country: String?
    var searchResultLimit: String?
    
}
