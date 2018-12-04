import Foundation

let baseURL = URL(string: "https://itunes.apple.com/search?")!
// Example URL https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo

class SearchResultController {
    
    private enum HTTPMethod: String {
        case GET = "GET"
        case PUT = "PUT"
        case POST = "POST"
        case DELETE = "DELETE"
    }
    
    var searchResults: [SearchResult] = []
    
    func performSearch(_ searchTerm: String, _ resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let searchItem = URLQueryItem(name: "term", value: searchTerm)
        let searchType = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchItem, searchType]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { data,_,error in
            
            if let error = error {
                NSLog("Data Task Error: \(error)")
                completion(nil, NSError())
                return
            }
            guard let data = data else {
                NSLog("Error: No data returned: \(error ?? NSError())")
                completion(nil, NSError())
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataResults = try jsonDecoder.decode(SearchResult.SearchResults.self, from: data)
                self.searchResults = dataResults.results
                completion(self.searchResults, nil)
                
            } catch {
                NSLog("Unable to decode data into itunes search results: \(error)")
                completion(nil, NSError())
                return
            }
        }
        dataTask.resume()
    }
}
