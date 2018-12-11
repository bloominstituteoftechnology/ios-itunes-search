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

struct SearchResults {
    let results: [SearchResult]
}
