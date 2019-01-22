import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String

    // Would have been "CodingKeys" otherwise.
    enum ParameterKeyValue: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
