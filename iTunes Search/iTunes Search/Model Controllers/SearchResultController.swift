import Foundation

let baseURL = "https://itunes.apple.com/search?"
// Example URL https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo

class SearchResultController {
    
    var searchResults: [SearchResult] = []
    
    func performSearch(_ searchTerm: String, _ resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        let urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let searchItem = URLQueryItem(name: "term", value: searchTerm)
        let searchType = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents.queryItems = [searchItem, searchType]
        
        guard let requestURL = URLComponents.url else {
            
        }
        
    }
}
