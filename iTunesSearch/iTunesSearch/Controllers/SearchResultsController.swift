//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Cameron Collins on 4/6/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import Foundation

protocol SearchResultsDelegate {
    func updateTableView()
}

class SearchResultsController {
    
    //Enumerator
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum selected: String {
        case Apps = "software"
        case Music = "musicArtist"
        case Movies = "movie"
    }
    
    //Variables
    var delegate: SearchResultsDelegate?
    let baseURL = URL(string: "https://itunes.apple.com")!
    lazy var searchURL = URL(string: "/search", relativeTo: baseURL)!
    var task: URLSessionTask?
    var searchResults: [SearchResult] = [] //Data Source
    var selectedSegment: selected = .Apps
    
    
    //Functions
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        task?.cancel()
        
        //Get Search Bar Text
        guard let tableViewController = delegate as? SearchResultsTableViewController else {
            return
        }
        
        //Not sure what this does?
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let artistQuery = URLQueryItem(name: "entity", value: selectedSegment.rawValue)
        let searchQuery = URLQueryItem(name: "term", value: tableViewController.searchBar?.text ?? "")
        urlComponents?.queryItems = [artistQuery, searchQuery]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL Nil")
            completion()
            return
        }
        print(requestURL)
    
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let self = self else { return }
            guard let data = data else {
                print("No data returned from dataTask")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = search.results
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            completion()
        }
        task?.resume()
    }
    
}
