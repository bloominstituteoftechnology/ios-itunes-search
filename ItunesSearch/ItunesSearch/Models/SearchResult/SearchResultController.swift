//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by brian vilchez on 9/4/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

class SearchResultController {
    
    var artistSearchedResults:[Artist] = []
    var movieSearchedResults: [Movie] = []
    var softwareSearchedResults: [Software] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search")
    
    func performSearch(with searchTerm: String, resultType: ResultType,completion: @escaping(Error?) -> Void) {
        guard let itunesURL = baseURL else {return}
        
        switch resultType {
        case .musicTrack:
            var urlComponents = URLComponents(url: itunesURL, resolvingAgainstBaseURL: true)
            let searchedItems = URLQueryItem(name: "term", value: searchTerm.lowercased())
            let entityItem = URLQueryItem(name: "entity", value: "song")
             let limit = URLQueryItem(name: "limit", value: "10")
            
            urlComponents?.queryItems = [searchedItems,entityItem,limit]
            guard let requestURL = urlComponents?.url else { return }
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = HTTPMethod.get.rawValue
            print(request)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error as NSError? {
                    NSLog("unable to connect \(error.localizedDescription)")
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let artist = try decoder.decode(ArtistSearchResults.self, from: data)
                    self.artistSearchedResults = artist.results
                } catch {
                    NSLog("failed to decode data \(error.localizedDescription)")
                }
            }.resume()
            
        case .software:
            var urlComponents = URLComponents(url: itunesURL, resolvingAgainstBaseURL: true)
            let searchedItem = URLQueryItem(name: "term", value: searchTerm.lowercased())
            let entity = URLQueryItem(name: "entity", value: "software")
            
            urlComponents?.queryItems = [searchedItem,entity]
            guard let requestURL = urlComponents?.url else { return }
            
            var request = URLRequest(url: requestURL)
                       request.httpMethod = HTTPMethod.get.rawValue
                       print(request)
                       URLSession.shared.dataTask(with: request) { (data, response, error) in
                           if let error = error as NSError? {
                               NSLog("unable to connect \(error.localizedDescription)")
                           }
                           guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
                           guard let data = data else { return }
                           
                           do {
                               let decoder = JSONDecoder()
                               decoder.keyDecodingStrategy = .convertFromSnakeCase
                               let software = try decoder.decode(SoftwareResults.self, from: data)
                            self.softwareSearchedResults = software.results
                           } catch {
                               NSLog("failed to decode data \(error.localizedDescription)")
                           }
                       }.resume()
        case .movie:
            var urlComponents = URLComponents(url: itunesURL, resolvingAgainstBaseURL: true)
            let searchedItem = URLQueryItem(name: "term", value: searchTerm.lowercased())
            let entity = URLQueryItem(name: "entity", value: "movie")
            
            urlComponents?.queryItems = [searchedItem,entity]
            guard let requestURL = urlComponents?.url else { return }
            
            var request = URLRequest(url: requestURL)
                       request.httpMethod = HTTPMethod.get.rawValue
                       print(request)
                       URLSession.shared.dataTask(with: request) { (data, response, error) in
                           if let error = error as NSError? {
                               NSLog("unable to connect \(error.localizedDescription)")
                           }
                           guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
                           guard let data = data else { return }
                           
                           do {
                               let decoder = JSONDecoder()
                               decoder.keyDecodingStrategy = .convertFromSnakeCase
                               let movie = try decoder.decode(MovieResults.self, from: data)
                            self.movieSearchedResults = movie.results
                           } catch {
                               NSLog("failed to decode data \(error.localizedDescription)")
                           }
                       }.resume()
        }
        

    }
    
    enum HTTPMethod:String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

    
}


