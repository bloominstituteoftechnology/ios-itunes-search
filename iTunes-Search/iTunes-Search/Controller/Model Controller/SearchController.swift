//
//  SearchController.swift
//  iTunes-Search
//
//  Created by Kenny on 1/14/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//
import Foundation

class SearchController {
    //MARK: Class Properties
    let baseURL: URL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []

    //MARK: Methods
    /**
        Constructs the proper URL, executes an async call to the iTunes API and returns search results or an error
     - Parameter resultType: Ensures that the proper URL is used in the search query (i.e. using .movie would search through the movies API)
     - Parameter complete: Completion closure - returns an error if there' an error retrieving data
        - Parameter error: This will be nil if data is returned. If it isn't nil and there's no description, check the console
     */
    func performSearch(searchTerm: String, resultType: ResultType, complete: @escaping (_ error: Error?) -> ()) {
        let urlComponents = constructUrl(resultType: resultType, searchTerm: searchTerm)
        guard let request = createRequest(urlComponents: urlComponents) else {
            complete(NSError())
            return
        }
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            if let error = error {
                complete(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from dataTask")
                complete(NSError())
                return
            }
            let jsonResult = self.decodeSearchResult(data: data)
            complete(jsonResult)
        }).resume()
    }
    
    //MARK: Helper Methods
    /**
        Construct URLs for performSearch method
        - parameter urlString: Base Search URL
        - parameter resultType: Used to determine which section of the API to search
     */
    private func constructUrl(resultType: ResultType, searchTerm: String) -> URLComponents? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let termQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [
            termQueryItem,
            entityQueryItem
        ]
        return urlComponents
    }
    
    /**
        Construct a request given URLComponents
     */
    private func createRequest(urlComponents: URLComponents?) -> URLRequest? {
        guard let requestUrl = urlComponents?.url else {
            NSLog("request URL is nil")
            return nil
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        return request
    }
    
    /**
        Decode Data into SearchResult and append to searchResults or return an error
     */
    private func decodeSearchResult(data: Data) -> Error? {
        let jsonDecoder = JSONDecoder()
        do {
            let iTunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
            self.searchResults = iTunesSearch.results
            return nil
        } catch {
            NSLog("Data is not decodable to JSON, Data: \(data.description)")
            return error
        }
    }
}
