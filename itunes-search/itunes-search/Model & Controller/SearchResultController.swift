import Foundation

class SearchResultController {
    
    var searchResults: [SearchResult]? = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, searchCountry: SearchCountry = .USA, completion: @escaping (Error?) -> Void) {
        
        guard let baseURL = URL(string: "https://itunes.apple.com/search")
            else {
                fatalError("Unable to construct baseURL")
        }
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchCountryQueryItem = URLQueryItem(name: "country", value: searchCountry.rawValue)
        let mediaTypeQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        let limitTypeQueryItem = URLQueryItem(name: "limit", value: String(10))
        
        urlComponents.queryItems = [searchTermQueryItem, searchCountryQueryItem, mediaTypeQueryItem, limitTypeQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Unable to unwrap data")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                switch resultType {
                case .software:
                    let search = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = search.results
                    completion(nil)
                case .music:
                    let search = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = search.results
                    completion(nil)
                case .movie:
                    let search = try jsonDecoder.decode(SearchResults.self, from: data)
                    self.searchResults = search.results
                    completion(nil)
                }
                
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(error)
//                print(String(data: data, encoding: .utf8)!)
//                print(request)
                        return
            }
        }
        dataTask.resume()
    }
}
