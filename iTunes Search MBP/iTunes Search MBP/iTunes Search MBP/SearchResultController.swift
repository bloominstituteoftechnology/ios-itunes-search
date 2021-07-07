
import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
    
        // let url = baseURL.appendingPathComponent("")
       var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem1 = URLQueryItem(name: "entity", value: resultType.rawValue)
        // let resultTypeQueryItem2 = URLQueryItem(name: "attribute", value: resultType.rawValue)
        components?.queryItems = [searchQueryItem, resultTypeQueryItem1]
        
        guard let searchURL = components?.url else {
            NSLog("Couldn't make requestURL")
            completion(NSError())
            return
        }
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET" // PUT, POST, DELETE
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
        }
            let jsonDecoder = JSONDecoder()
           // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                let result = try jsonDecoder.decode(SearchResult.SearchResults.self, from: data)
                self.searchResults = result.results
                completion(nil)
                return
            } catch {
                    NSLog("No data returned from data task")
                    completion(nil)
                    return
                
            }
        
    }.resume()
}
}

