import UIKit

class SearchResultController: UITableViewController {
    static let endpoint = "https://itunes.apple.com/"
    
    let baseURL = URL(string: endpoint)
    
    var searchResults: [SearchResult] = []
}
