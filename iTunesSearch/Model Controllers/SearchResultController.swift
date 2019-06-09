import Foundation

class SearchResultController {
    
    //MARK: Properties
    var searchResults: [SearchResult] = []
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    
    //MARK: Search Function
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        
        
        var urlCompontents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryItems     = URLQueryItem(name: "term", value: searchTerm)
        let queryItemsType = URLQueryItem(name: "entity", value: resultType.rawValue)
    
        urlCompontents?.queryItems = [queryItems, queryItemsType]
        
        guard let requestURL = urlCompontents?.url else {
            NSLog("URL could not be found")
            return }
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                completion(error)
                NSLog("Could not load data from URL: \(error)")
                return
            }
            
            guard let data = data else {
                completion(NSError())
                NSLog("Could not parse data")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            
            do {
                let dataLoadedSearchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = dataLoadedSearchResults.results
                completion(nil)
                
            } catch {
                
                completion(error)
                NSLog("Error")
            }
            
        }.resume()
        print(requestURL)
    }
}
