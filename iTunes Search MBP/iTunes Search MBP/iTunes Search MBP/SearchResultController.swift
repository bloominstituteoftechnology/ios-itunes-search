
import Foundation

class SearchResultController {
    
    let endpoint = "https://itunes.apple.com/search"
    var searchResults: [SearchResult] = []
    
    func performSearch (with searchTerm: String , resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        guard let baseURL = URL(string: endpoint) else { fatalError("Unable to construct baseURL") }
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else { fatalError("Unable to resolve baseURL to components") }
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        guard let searchURL = urlComponents.url else { return }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET" // PUT, POST, DELETE
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NSError())
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
        }
            
            //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                let jsonDecoder = JSONDecoder()
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

