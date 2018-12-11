
import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    typealias CompletionHandler = (Error?) -> Void
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
    
        let url = baseURL.appendingPathComponent("")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        components?.queryItems = [searchQueryItem, resultTypeQueryItem]
        
        URLSession().dataTask(with: url) { (data, _, error) in
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
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
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
        
    }
}
}

