//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by Casualty on 9/8/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import Foundation

class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    private func addImageData(to searchResult: SearchResult, imageData: Data) {
        guard let index = searchResults.firstIndex(of: searchResult) else { return }
        
        searchResults[index].imageData = imageData
    }
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        searchResults = []

        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchTerm = URLQueryItem(name: "term", value: searchTerm)
        let resultType = URLQueryItem(name: "entity", value: resultType.rawValue)
        components?.queryItems = [searchTerm, resultType]
        
        guard let requestURL = components?.url else {
            print("Error making URL request.")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error gathering data \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No Data Available")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {

                let results = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = results.results
                completion(nil)
                
            } catch {
                print("Error decoding data \(error)")
                completion(nil)
                return
            }
            
            
            }.resume() // Stop forgetting to do this!!!!
    }

    func loadImage(_ searchResult: SearchResult, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: searchResult.imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            self.addImageData(to: searchResult, imageData: data)
            completion(nil)
            }.resume()
    }
    
}
