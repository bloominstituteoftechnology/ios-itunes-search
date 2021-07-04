import Foundation

// Example URL https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo

//searchURL    https://itunes.apple.com/search?term=Yelp&entity=software
//searchURL    https://itunes.apple.com/search?term=Beach%20Boys&entity=musicTrack

class SearchResultsController {
    
    static let endpoint = "https://itunes.apple.com/search"
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, _ searchLimit: String?, completion: @escaping ([SearchResult]?, Error?) -> Void ) {
        
        guard let baseURL = URL(string: SearchResultsController.endpoint) else { fatalError("Unable to construct baseURL") }
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { fatalError("Unable to resolve baseURL to components") }
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let typeOfQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let searchLimitQueryItem = URLQueryItem(name: "limit", value: searchLimit)
        
        urlComponents.queryItems = [searchQueryItem, typeOfQueryItem, searchLimitQueryItem]
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, NSError())
                return
            }
        
            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let resultFromSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = resultFromSearch.results
                completion(self.searchResults, nil)
            } catch {
                NSLog("Unable to decode data into search query \(error)")
                completion(nil, NSError())
                return
            }
        }
        dataTask.resume()
    }
    
}




