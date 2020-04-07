//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Chris Dobek on 4/6/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation

protocol SearchResultsDelegate {
    func updateTableView()
}

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum selected: String {
        case Apps = "software"
        case Music = "musicArtist"
        case Movies = "movies"
    }
    
    
    var delegate: SearchResultsDelegate?
    private let baseURL = URL(string: "https://itunes.apple.com/")!
    private lazy var searchResultsURL = URL(string: "/search", relativeTo: baseURL)!
    private var task: URLSessionTask?
    var searchResults: [SearchResult] = []
    var selectedSegment: selected = .Apps
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
            guard let tableViewController = delegate as? SearchResultsTableViewController else {
                return
            }
        
            task?.cancel()
            var urlComponents = URLComponents(url: searchResultsURL, resolvingAgainstBaseURL: true)
            let artistQuery = URLQueryItem(name: "entity", value: selectedSegment.rawValue)
            let searchQuery = URLQueryItem(name: "term", value: tableViewController.searchBarResults?.text)
            urlComponents?.queryItems = [artistQuery, searchQuery]


            guard let requestURL = urlComponents?.url else {
                print("Request URL is nil")
                return
            }
            
            print(requestURL)

            var request = URLRequest(url: requestURL)
            request.httpMethod = HTTPMethod.get.rawValue

                task = URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
                
                    if let error = error {
                    print("Error getting data: \(error)")
                    return
                }
                    guard let self = self else { return }
                    guard let data = data else {
                        print("No data returned return from dataTask")
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
