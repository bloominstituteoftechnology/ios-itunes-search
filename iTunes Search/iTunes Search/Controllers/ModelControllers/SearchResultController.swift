//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by James McDougall on 1/26/21.
//

import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    private let baseURL = URL(string: "https://itunes.apple.com")!
    private lazy var searchURL = URL(string: "/search?", relativeTo: baseURL)!
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error fetching your search term: \(error)")
                return
            }
            
            guard let data = data else {
                print("Error fetching data")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let iTunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: iTunesSearch.results)
                completion(nil)
            } catch {
                print("Unable to decode data into object of type SearchResults: \(error)")
                completion(error)
            }
        }
        task.resume()
    }
}
