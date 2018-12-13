import UIKit

// https://itunes.apple.com/search

struct SearchResult: Codable {
    let title: String
    let creator: String

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    // Must conform to Codable to work in the SearchResultController
    let results: [SearchResult]
}
