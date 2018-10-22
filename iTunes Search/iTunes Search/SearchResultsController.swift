import UIKit

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    private let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("unable to resolve baseURL to components")
        }
        
        let searchQueryItem = URLQueryItem(name: "term", value:searchTerm)
        let mediaQueryItem = URLQueryItem(name: "media", value:resultType.rawValue)
        
        urlComponents.queryItems = [searchQueryItem, mediaQueryItem]
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            
            data, _, error in
            
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
                
                let searchResults = try jsonDecoder.decode(ResultList.self, from: data)
                self.searchResults = searchResults.results
                
                completion(self.searchResults, nil)
            } catch {
                NSLog("UNable to decode data into people")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
