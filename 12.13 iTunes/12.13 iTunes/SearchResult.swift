import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct ResultsList: Codable {
    let results: [SearchResult]
}
