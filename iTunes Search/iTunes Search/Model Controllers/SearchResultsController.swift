import Foundation

// Example URL https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo

class SearchResultsController {
    
    static let endpoint = "https://itunes.apple.com/search?"
    
    static func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void ) {
        
        guard let baseURL = URL(string: SearchResultsController.endpoint) else { fatalError("Unable to construct baseURL") }
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { fatalError("Unable to resolve baseURL to components") }
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let typeOfQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents.queryItems = [searchQueryItem, typeOfQueryItem]
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        print(searchURL)
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(nil, error)
                }
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let resultFromSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                let returnedSearchItem = resultFromSearch.results
                completion(returnedSearchItem, nil)
            } catch {
                NSLog("Unable to decode data into search query \(error)")
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
    
}


