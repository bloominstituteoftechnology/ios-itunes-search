import Foundation

class SearchResultController {
// https://itunes.apple.com/search

    static let endpoint = "https://itunes.apple.com/search"

    guard let baseURL = URL(string: endpoint) else {
        fatalError("Unable to construct baseURL")
    }

}
