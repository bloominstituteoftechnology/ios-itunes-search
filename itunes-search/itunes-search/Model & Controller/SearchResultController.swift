import Foundation

private let baseURL = URL(string: "https://itunes.apple.com/search")!

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let mediaTypeQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        let limitTypeQueryItem = URLQueryItem(name: "limit", value: String(10))
        
        urlComponents.queryItems = [searchTermQueryItem, mediaTypeQueryItem, limitTypeQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Unable to unwrap data")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let newSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = newSearch.results
                completion(self.searchResults, nil)
            } catch  {
                NSLog("Unable to decode data: \(error)")
                completion(nil,NSError())
                return
            }
        }
        dataTask.resume()
    }
}
