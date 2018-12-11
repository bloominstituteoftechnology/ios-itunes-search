import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    
    // datasource for tableView
    var searchResults: [SearchResults] = []
    
    typealias CompletionHandler = (Error?) -> Void
    
    func performSearch(with searchTerm: String, completion: @escaping CompletionHandler ) {
        
    }
}
