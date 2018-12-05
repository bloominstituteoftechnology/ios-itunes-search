import UIKit

class SearchResultController: UITableViewController {
    static let endpoint = "https://itunes.apple.com/"
    

    
    var searchResults: [SearchResult] = []
    
   static func performSearch(searchTerm: String, resultType: ResultType, completion: () -> NSError?) {
    
        guard let baseURL = URL(string: endpoint) else {fatalError("Unable to construct baseURL") }
    
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {
                fatalError("Unable to resolve baseURL to components")
            }
    }
        
}
