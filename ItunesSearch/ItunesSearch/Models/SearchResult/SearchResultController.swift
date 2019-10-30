//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by brian vilchez on 9/4/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var searchResults:[SearchResult] = []
    let baseURL = URL(string: "https://itunes.apple.com/search?")
    
    func performSearch(with searchTerm: String, resultType: ResultType,completion: @escaping(Error?) -> Void) {
        
        guard let itunesURL = baseURL else {return}
        
        switch resultType {
        case .movie:
            var urlComponents = URLComponents(url: itunesURL, resolvingAgainstBaseURL: true)
            let searchedItems = URLQueryItem(name: "term=", value: searchTerm)
            urlComponents?.queryItems = [searchedItems]
            guard let requestURL = urlComponents?.url else { return }
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = HTTPMethod.get.rawValue
            
            
        case .software:
            break
        case .musicTrack:
            break
        }
        

    }
    
    enum HTTPMethod:String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

    
}


