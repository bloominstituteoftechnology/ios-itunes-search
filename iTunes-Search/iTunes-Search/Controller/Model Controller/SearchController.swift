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


    /**
        Constructs the proper URL, executes an async call to the iTunes API and returns search results or an error
     - Parameter resultType: Ensures that the proper URL is used in the search query (i.e. using .movie would search through the movies API)
     - Parameter complete: Completion closure - returns an error if there' an error retrieving data
        - Parameter error: This will be nil if data is returned. If it isn't nil and there's no description, check the console
     */
    func performSearch(searchTerm: String, resultType: ResultType, complete: @escaping (_ error: Error?) -> ()) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let urlQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [urlQueryItem]
        guard let requestUrl = urlComponents?.url else {
            NSLog("request URL is nil")
            complete(NSError())
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
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
            let jsonDecoder = JSONDecoder()
            do {
                let musicSearch = try jsonDecoder.decode(SearchResult.self, from: data)
                self.searchResults.append(musicSearch)
            } catch {
                NSLog("Data is not decodable to JSON, Data: \(data.description)")
                complete(error) //error from decoder
            }
            complete(nil)
        }).resume()
    }

}
