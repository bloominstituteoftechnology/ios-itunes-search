import Foundation
let endpoint = "https://itunes.apple.com/search"

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    //perform search
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?,NSError?) -> Void) {
        guard let baseURL = URL(string: endpoint)
            else {
                fatalError("Unable to construct baseURL")
        }
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {
                fatalError("Unable to resolve baseURL to components")
        }
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        let searQuerEntity = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchQueryItems, searQuerEntity]
        
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        
    }
    
    
}
